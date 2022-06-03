## Outline

- **What** is data validation?

- **Why** is data validation difficult?

- **How** can data validation be made easy?

- **Where** can I use it?

# What is data validation?

## Detect good data

::: incremental

- Eventually all data is sequences of bits

- Data must conform to expected shapes

- **Data validation** $=$ check expectations

- Data validation $\neq$ Information validation

:::

## Expectations

::: incremental

- **completeness**\
   *internal*: e.g. all authors have names\
   *external*: e.g. all authors are listed

- **constraints**\
  e.g. year < 2022

- **consistency**\
  e.g. birth < death (except time-travellers)

:::

## Data quality

::: incremental

- code $\Rightarrow$ **unit tests**

- data $\Rightarrow$ **data validation**

- **Violations accumulate**\
  if expectations are not enforced

:::

# Why is data validation difficult?

## Challenges

::: incremental

- **Big data** & **data integration**\
  e.g. bibliographic data + knowledge graphs

- **Many formats** & different expectations

- Diverse **validation technologies**

:::

## Technologies

::: incremental

- Custom **parser/rules** (*if ... then ...*)

- **Schema languages**

  ------ --------------------
  JSON   JSON Schema            
  XML    XSD, DTD, Schematron
  RDF    SHACL/ShEx             
  String RegEx, EBNF            
  MARC   Avram                  
  ------ --------------------

:::

## Levels of description

~~~{.graphviz}
digraph {
  Bytes -> XML;
  XML -> marcxml;
  marcxml[label="MARC/XML"];
  marcxml -> MARC;
  MARC -> Custom;
  Custom[label="MARC21 Subset"]
}
~~~

<!--
             XML Schema            Avram Schema
-->

# How to make data validation easy

## Abstraction

~~~{.graphviz width=200%}
digraph {
  rankdir="LR";
  node [shape=box, style=rounded, fontname="sans-serif"]
  edge [fontname = "sans-serif"]
  Service[label="Validation Service"]
  Data[shape=none]
  Formats -> Service:sw [label=configuration]
  Schemas -> Formats
  Data -> Service:nw [penwidth=2,label=validate]
  Data -> Service:w [label=errors,dir=back]
}
~~~

## API

Request
  : data (file, URL, file or stream) and\
    format identifier (+ optional version)

Response
  : list of errors

Error
  : message (+ optional position)

# Where can I use it?

## Validation Server

- **Web service** to validate data

- Configured with formats and schemas

- [github.com/gbv/validation-server](https://github.com/gbv/validation-server) (Node)

- [format.gbv.de/validate](https://format.gbv.de/validate/)

## Request API

- HTTP GET & POST
  - raw data or web form file upload
  - Use in any web application (CORS)

- Web interface

- Command line (requires configuration)

## Demo

...

## Request example

`POST https://format.gbv.de/validate/{format}`

`curl https://format.gbv.de/validate/vzg-article --data-binary @article.json`

## Response Format

~~~json
[ 
  {
    "message": "must be array",
    "position": {
      "jsonpointer": "/authors"
    }
  }
]
~~~

## Benefits

- Registry of known formats and schemas
- No local installation required
- Unified request format
- Unified error format

# Summary & Outlook

## Data quality paradigms

::: incremental

- **Authority based**\
  done by experts is good by definition

- **Evidence based**\
  continuous measuring & improving

:::

## Abstraction

~~~{.graphviz width=200%}
digraph {
  rankdir="LR";
  node [shape=box, style=rounded, fontname="sans-serif"]
  edge [fontname = "sans-serif"]
  Service[label="Validation Service"]
  Data[shape=none]
  Formats -> Service:sw
  Schemas -> Formats
  Data -> Service:nw [penwidth=2,label=validate]
}
~~~

## Implementation

- Validation Server

- Configure formats with schemas

- Public instance [format.gbv.de/validate](https://format.gbv.de/validate/)

## Planned features

- Support more schema languages (Avram, EBNF, Schematron SHACL/ShEx)

- Support validating MARC21

- Show error context

## Alternatives

- Build-in rules of black-box library system 😕

- Validator engines for each schema language (e.g. `xmllint`) 😐

- Metadata Quality Assurance Framework 😀

