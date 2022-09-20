# ALTO to TEI tools

This project contains tools for transforming ALTO into TEI P5 for import to the text service. It was developed within the Trykkefrihedens Skrifter.

## Prerequisites

Requires saxon (xslt 3 processor), xmllint, perl and bash. For instance:

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

If you by any chance have old stuff in your directory, make sure it is really clean.

```
clean_really_clean.sh
```

The get all the alto files into the ./data directories, use the
`./import_alto.pl` script. It has a help function

```
./import_alto.pl --help
```

which gives

```
./import_alto.pl --help 
    Correct usage:
    ./import_alto.pl <options>
        where options are
        --pattern=<regex> 
	a regex matching the first few characters in an alto file's name
        --from=<directory>
        where to read files
	--to=<directory>
	where to write files
```

The command

```
./import_alto.pl --pattern='\d_\d\d' --from ../trykkefrihedens-skrifter/ --to data/
```
copies recursively xml-files  from ../trykkefrihedens-skrifter/ to data/, if the files matches the regex `\d_\d\d` whereas

```
./import_alto.pl --pattern='^acc' --from ../louis-hjelmslev-corpus/  --to data/
```

does the same for files matching regex `^acc` in directory ../louis-hjelmslev-corpus/

As a matter of fact, the script does not do the job, it generates a
shell script that does it. So, for example, you run the import of
louis-hjelmslev-corpus like this:

```
./import_alto.pl --pattern='^acc' --from ../louis-hjelmslev-corpus/  --to data/ | /bin/bash
```

The alto files are basic data maintained elsewhere, and should **not** be under version control
__here__. 

### 2. Validation is easy

You may, if you think it's useful, validate the files. E.g.,

```
find data -name '*.xml' -exec xmllint --noout --schema alto-3-1.xsd {} \; > validation.text  2>&1 
```

### 3. create lists of ALTO files related to each publication in the collection

```
 collect_alto
```

### 4. transform all the ALTO into TEI

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

Again, these files should not (it is derived data) be under version control in this project.

### 5. store into database and index

The code for this is in [solr-and-snippets](https://github.com/Det-Kongelige-Bibliotek/solr-and-snippets)

