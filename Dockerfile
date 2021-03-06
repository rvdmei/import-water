FROM openmaptiles/postgis:2.2
ENV IMPORT_DATA_DIR=/import \
    NATURAL_EARTH_DB=/import/natural_earth_vector.sqlite

RUN apt-get update && apt-get install -y --no-install-recommends \
      wget \
      unzip \
      sqlite3 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p $IMPORT_DATA_DIR \
    && wget --quiet http://data.openstreetmapdata.com/water-polygons-split-3857.zip \
    && unzip -oj water-polygons-split-3857.zip -d $IMPORT_DATA_DIR \
    && rm water-polygons-split-3857.zip

RUN wget --quiet http://data.openstreetmapdata.com/simplified-water-polygons-complete-3857.zip \
    && unzip -oj simplified-water-polygons-complete-3857.zip -d $IMPORT_DATA_DIR \
    && rm simplified-water-polygons-complete-3857.zip

WORKDIR /usr/src/app
COPY . /usr/src/app
CMD ["./import-water.sh"]
