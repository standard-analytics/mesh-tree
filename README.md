# mesh-tree

[![build status](https://img.shields.io/travis/scienceai/mesh-tree/master.svg?style=flat-square)](https://travis-ci.org/scienceai/mesh-tree)
[![coverage status](https://img.shields.io/coveralls/scienceai/mesh-tree.svg?style=flat-square)](https://coveralls.io/r/scienceai/mesh-tree?branch=master)
[![npm version](https://img.shields.io/npm/v/mesh-tree.svg?style=flat-square)](https://www.npmjs.com/package/mesh-tree)

Utility functions for traversing the Medical Subject Heading (MeSH) ontology tree

<p align="center">
  <img src="./mesh_over_time.png", width="500"/>
</p>

Medical Subject Headings (MeSH) is an ontology for classifying information within the biomedical domain.

### Usage

```sh
$ npm install mesh-tree --save
```

To use in a single process, specify path to the MeSH levelgraph DB. If config object is empty, mesh-tree will use $PATH_TO_MESH_DB as the path:

```js
import MeshTree from 'mesh-tree';

let meshTree = new MeshTree({
  dbPath: '/path/to/mesh/db'
});

meshTree.getAllDescUIs().then(result => {
  console.log(result);
});
```

To use with multiple processes, pass in a [`multilevel`](https://github.com/juliangruber/multilevel) client.

+ server:

  ```js
  import level from 'level';
  import multilevel from 'multilevel';
  import net from 'net';

  let db = level('/path/to/mesh/db');
  net.createServer(con => {
    con.pipe(multilevel.server(db)).pipe(con);
  }).listen(meshTreePort);
  ```

+ client:

  ```js
  import MeshTree from 'mesh-tree';
  import multilevel from 'multilevel';
  import net from 'net';

  let db = multilevel.client();
  let con = net.connect(meshTreePort);
  con.pipe(db.createRpcStream()).pipe(con);

  let meshTree = new MeshTree({
    level: db
  });

  meshTree.getAllDescUIs().then(result => {
    console.log(result);
  });
  ```

### API

###### `getAllDescUIs(opts)`

Returns array of all descriptor record UIs. Four types of descriptor records exist: `TopicalDescriptor`, `GeographicalDescriptor`, `PublicationType`, `CheckTag`. By default, only `TopicalDescriptor` and `GeographicalDescriptor` are included.

`opts`:
  - `format`: `rdf` or `mesh` for output format
  - `classes`: array of descriptor record types to include (default `['TopicalDescriptor', 'GeographicalDescriptor']`)

###### `getAllSCRChemicalUIs(opts)`

Returns array of all chemical supplementary record UIs

`opts`:
  - `format`: `rdf` or `mesh` for output format

###### `getAllSCRDiseaseUIs(opts)`

Returns array of all disease (rare) supplementary record UIs

`opts`:
  - `format`: `rdf` or `mesh` for output format

###### `getAllSCRProtocolUIs(opts)`

Returns array of all protocol (e.g., cancer-related) supplementary record UIs

`opts`:
  - `format`: `rdf` or `mesh` for output format

###### `getWikiEntry(opts)`

Returns the cleaned text output of the wikipedia page corresponding to the descriptor record UI

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `level`:
    - `0` - abstract only
    - `1` - all text

One can extract either the abstract or entire body of text from wikipedia (cleaned, without link info, references, citations, etc.) for a particular concept, based on the preferred concept term. The function automatically follows any automatic redirects. For example, in MeSH the concept `Calcimycin` corresponds to the wikipedia page on `A23187`, which is an accepted term under the MeSH concept but not the preferred term.

###### `getTreeNumbers(opts)`

Returns array of tree numbers by descriptor record unique identifier.

Example: `'D000001'` returns `['D03.438.221.173']`

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `treeNumberToUI(opts)`

Returns descriptor record unique identifier by tree number.

Example: `'D03.438.221.173'` returns `'D000001'`

`opts`:
  - `treeNum`: either RDF URL id with tree number or tree number by itself
  - `format`: `rdf` or `mesh` for output format

###### `getCategory(opts)`

Returns top-level MeSH category

Example: `'D000001'` returns `'Chemicals and Drugs'`

`opts`:
  - `id`: either RDF URL id or MeSH UI

###### `getPrefTerm(opts)`

Returns the preferred term by descriptor record unique identifier (i.e., the preferred term of the preferred concept).

Example: `'D000001'` returns `'Calcimycin'`

`opts`:
  - `id`: either RDF URL id or MeSH UI

###### `getAllTerms(opts)`

Returns all terms by descriptor record unique identifier (i.e., all terms for all concepts, both preferred and not).

Example: `'D000001'` returns `['A23187, Antibiotic', 'Antibiotic A23187', 'A23187', 'A 23187', 'A-23187', 'Calcimycin']`

Can also use chemical supplementary concept records UIs here as well:

Example: `'C025734'` returns `['CH-A1-MG', 'alpha 1 microglobulin, chorionic', 'chorionic alpha 1-microglobulin', 'chorionic alpha(1)-microglobulin']`

`opts`:
  - `id`: either RDF URL id or MeSH UI

###### `getScopeNote(opts)`

Returns scope note for descriptor record unique identifier (scope notes are contained in the preferred concept record).

Example: `'D000001'`, via concept `'M0000001'`, returns `'An ionophorous, polyether antibiotic from Streptomyces chartreusensis. It binds and transports CALCIUM and other divalent cations across membranes and uncouples oxidative phosphorylation while inhibiting ATPase of rat liver mitochondria. The substance is used mostly as a biochemical tool to study the role of divalent cations in various biological systems.'`

`opts`:
  - `id`: either RDF URL id or MeSH UI

###### `getParents(opts)`

Returns parent descriptor records UIs (returns an array as records can exist in multiple tree branches).

Example: `'D000001'` returns `['D001583']`
Example: `'D005138'` returns `['D006197', 'D005123']`

If id provided is SCR, returns parent descriptor record UIs mapped from supplementary concept record UI.

Example: `'C041293'` returns `['D011140']`
Example: `'C025735'` returns `['D001286', 'D002164', 'D012602']`

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `getAncestors(opts)`

Returns all ancestor descriptor records UIs, following all parent branches. Returns an array.

Example: `'D000001'` returns `['D001583', 'D006574', 'D006571']`
Example: `'D005138'` returns `['D005123', 'D006197', 'D005145', 'D012679', 'D034582', 'D006257', 'D001829']`

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `getChildren(opts)`

Returns children descriptor records UIs (immediate, not descendants)

Example: `'D012343'` returns `['D012345', 'D000926', 'D012346']`

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `getSiblings(opts)`

Returns sibling descriptor records UIs (across all branches a descriptor record may exist under).

Example: `D015834 (Cochlear Diseases)` returns `D018159 (Endolymphatic Hydrops), D015837 (Vestibular Diseases), D007762 (Labyrinthitis)`

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `getCommonAncestors(opts)`

Takes as argument an array of descriptor record UIs and returns descriptor records UI of closest common ancestors of two or more descriptor record UIs (if a descriptor exists in more than one branch on the tree, there may be more than one common ancestor).

Example: `D012345 (RNA, Transfer, Amino Acid-Specific), D000926 (Anticodon)` returns `D012343 (RNA, Transfer)`

Example: `D000233 (Adenoidectomy), D014068 (Tonsillectomy), D007828 (Laryngoscopy)` returns `D013517 (Otorhinolaryngologic Surgical Procedures)`

Example: `D011434 (Proprioception), D014785 (Vision, Ocular), D004856 (Postural Balance)` returns `D012677 (Sensation)`

`opts`:
  - `ids`: Array of either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `isDescendantOf(id1, id2)`

Tests whether or not id2 is a descendant of id1 (child of >=1 depth). IDs can be either RDF URL ids or MeSH UIs.

###### `clusterDescUIs(idArray)`

Takes a flat array of descriptor record UIs and returns a nested tree structure based on parent-descendant relationships amongst all the array elements. In other words, it recreates a subtree based on the overarching MeSH ontology tree on a given list of element nodes.

For example, given `D000233 (Adenoidectomy), D014068 (Tonsillectomy), D007828 (Laryngoscopy), D013517 (Otorhinolaryngologic Surgical Procedures)`, the following is returned:

```
[
  {
    "@id": "http://id.nlm.nih.gov/mesh/D013517",
    "parent": null,
    "children": [
      {
        "@id": "http://id.nlm.nih.gov/mesh/D000233",
        "parent": "http://id.nlm.nih.gov/mesh/D013517"
      },
      {
        "@id": "http://id.nlm.nih.gov/mesh/D014068",
        "parent": "http://id.nlm.nih.gov/mesh/D013517"
      },
      {
        "@id": "http://id.nlm.nih.gov/mesh/D007828",
        "parent": "http://id.nlm.nih.gov/mesh/D013517"
      }
    ]
  }
]
```

An example for a list containing more than one "relative top-level" element, such as `D011434 (Proprioception), D014785 (Vision, Ocular), D004856 (Postural Balance)`, gives:

```
[
  {
    "@id": "http://id.nlm.nih.gov/mesh/D011434",
    "parent": null,
    "children": [
      {
        "@id": "http://id.nlm.nih.gov/mesh/D004856",
        "parent": "http://id.nlm.nih.gov/mesh/D011434"
      }
    ]
  },
  {
    "@id": "http://id.nlm.nih.gov/mesh/D014785",
    "parent": null
  }
]
```

###### `getPharmacologicalAction(opts)`

Tests whether a descriptor has pharmacological actions (in other words, if the descriptor is a drug). If true, returns array of descUI mappings of the pharmacological action, otherwise returns null.

Example: `'D000001' (Calcimycin)` returns `['D000900', 'D061207'] (Anti-Bacterial Agents, Calcium Ionophores)`

`opts`:
  - `id`: either RDF URL id or MeSH UI
  - `format`: `rdf` or `mesh` for output format

###### `getSchemaOrgType(opts)`

Performs mapping of MeSH concepts onto Schema.org classes (e.g., Drug)

`opts`:
  - `id`: either RDF URL id or MeSH UI

###### `createPropertiesObject(propRequestObj)`

Creates properties object from descriptor id.

Example `propRequestObj`:

```
{
  '@id': 'http://id.nlm.nih.gov/mesh/D000001',
  properties: ['name', 'description', 'synonyms', 'schemaOrgType', 'codeValue', 'codingSystem']
}
```

returns

```
{
  '@id': 'http://id.nlm.nih.gov/mesh/D000001',
  'name': 'Calcimycin',
  'description': 'An ionophorous, polyether antibiotic from Streptomyces chartreusensis. It binds and transports CALCIUM and other divalent cations across membranes and uncouples oxidative phosphorylation while inhibiting ATPase of rat liver mitochondria. The substance is used mostly as a biochemical tool to study the role of divalent cations in various biological systems.',
  'synonyms': ['A23187, Antibiotic', 'Antibiotic A23187', 'A23187', 'A 23187', 'A-23187'],
  'schemaOrgType': 'Drug',
  'codeValue': 'D000001',
  'codingSystem': 'MeSH'
}
```

## Test

Note that fixture data needs to be loaded into a test levelgraph db prior to running test.

```sh
$ npm run initdb-test
$ npm test
```

## Setup

To use with the full MeSH data:

#### 1. Fetch data

Raw data are available
[here](https://www.nlm.nih.gov/mesh/filelist.html) as ascii and XML formats. Registration is required: see the
[Memorandum of Understanding](https://www.nlm.nih.gov/mesh/2014/download/termscon.html).

Run `./bin/fetch_mesh.sh`. The script will prompt for the email used in registration. All relevant MeSH files are downloaded into `$HOME/data/mesh/`.

#### 2. Transform to RDF

See [HHS/meshrdf](https://github.com/HHS/meshrdf) for instructions on transforming MeSH from XML to RDF N-triples using Saxon (java). There are no issues with Saxon 9.6 home edition. Additional details are available at the meshrdf [website](http://hhs.github.io/meshrdf/). Note: still as of July 2015, there is an error in the `qual2015.dtd` file where the line `<!ENTITY  % DescriptorRecordSet SYSTEM "desc2014.dtd">` needs to be changed to `desc2015.dtd` given that all the most up-to-date files are used. Export the path of Saxon `$SAXON_JAR` and run `./bin/mesh_xml2rdf.sh`. The RDF N-triples file will be produced at `$HOME/data/mesh/RDF`.

#### 3. Import into Levelgraph-N3 DB

We utilize LevelGraph (which is built on top of LevelDB) with the LevelGraph-N3 extension for storing and accessing the MeSH ontology as RDF N-triples. Run `PATH_TO_MESH_RDF=... PATH_TO_MESH_DB=... npm run initdb` to stream the RDF data into the datastore (`npm run initdb-quiet` for quiet mode). Environment variables are as follows:

- `PATH_TO_MESH_RDF`: location of the N-triples file.
- `PATH_TO_MESH_DB`: specifies the target path to the LevelGraph database. This is then used during initialization by the mesh-tree module.

### License

[Apache 2.0](https://github.com/scienceai/mesh-tree/blob/master/LICENSE)
