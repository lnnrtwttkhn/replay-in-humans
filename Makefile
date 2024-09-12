IMAGES_URL=https://cloud.uni-hamburg.de/s/3M8QXPAm9T8nNjT/download
IMAGES_ARCHIVE=images.zip
IMAGES_DIR=images/

.PHONY: preview
preview:
	quarto preview

.PHONY: render
render:
	quarto render index.qmd
	
.PHONY: deploy
deploy: clean images
	quarto publish gh-pages

.PHONY: images
images:
	wget $(IMAGES_URL) -O $(IMAGES_ARCHIVE)
	unzip -j -o $(IMAGES_ARCHIVE) -d $(IMAGES_DIR)
	rm -f $(IMAGES_ARCHIVE)

.PHONY: data
data:
	datalad clone https://github.com/lnnrtwttkhn/highspeed-decoding/ data/highspeed
	datalad get data/highspeed/decoding/sub-*/data/sub-*_decoding.csv -J 8
	Rscript -e 'renv::run("notebooks/data.R")'

.PHONY: clean
clean:
	rm -rf _site $(IMAGES_DIR)*