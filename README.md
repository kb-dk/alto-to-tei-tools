# Trykkefrihedens Skrifter

This project contains tools for transforming ALTO into TEI P5 for import to the text service

## Prerequisites

Requires saxon (xslt 3 processor), perl and bash. For instance:

```
 sudo apt install libsaxon-java
 export SAXON_PATH=/usr/share/java/saxon.jar
```

## Running

### 1. copy ALTO files into the data area of this project

```
./import_alto.pl  | /bin/bash
```

You may, if you think it's useful, validate the files. E.g.,

```
find data -name '*.xml' -exec xmllint --noout --schema alto-3-1.xsd {} \; 2>&1 > validation.text
```

### 2. create lists of ALTO files related to each publication in the collection

```
 collect_alto
```

### 3. transform all the ALTO into TEI

```
 run_build
```

### 4. store into database and index

The code for this is in [solr-and-snippets](https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets)
