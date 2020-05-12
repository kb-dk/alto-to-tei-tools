# Trykkefrihedens Skrifter: ALTO tools

This project contains tools for transforming ALTO into TEI P5 for import to the text service

## Prerequisites

Requires saxon (xslt 3 processor), perl and bash. For instance:

```
 sudo apt install libsaxon-java
```
You have to have ALTO data available in order to use these tools.

Some scripts will need to know how to run saxon. They read the  SAXON_PATH enironmental variable.

```
 export SAXON_PATH=/usr/share/java/saxon.jar
```

## Running

### 1. copy ALTO files into the data area of this project

```
./import_alto.pl  | /bin/bash
```

You may, if you think it's useful, validate the files. E.g.,

```
find data -name '*.xml' -exec xmllint --noout --schema alto-3-1.xsd {} \; > validation.text  2>&1 
```

### 2. create lists of ALTO files related to each publication in the collection

```
 collect_alto
```

### 3. transform all the ALTO into TEI

Here java need to know the complete path to you saxon jar file. For instance

```
 export SAXON_PATH=/usr/share/java/saxon.jar
```

Then make the TEI files

```
 run_build
```

You may, if you think it's useful, validate the files. E.g.,

```
find tei_dir/ -name '*xml' -exec xmllint --noout --relaxng ./tei_all.rng {} \;  > tei_validation.text  2>&1 
```

### 4. store into database and index

The code for this is in [solr-and-snippets](https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets)

