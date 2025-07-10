Directory structure:
└── starknet-io-starknet-docs/
    ├── README.adoc
    ├── _typos.toml
    ├── antora.yml
    ├── lunr-tokenizer.js
    ├── package.json
    ├── playbook.yml
    ├── .htaccess
    ├── CI/
    │   ├── Jenkinsfile
    │   └── scripts/
    │       └── comment_pr.py
    ├── js/
    │   └── algolia-index.js
    ├── modules/
    │   ├── architecture/
    │   │   ├── nav.adoc
    │   │   └── pages/
    │   │       ├── accounts.adoc
    │   │       ├── blocks.adoc
    │   │       ├── cryptography.adoc
    │   │       ├── data-availability.adoc
    │   │       ├── fees.adoc
    │   │       ├── messaging.adoc
    │   │       ├── os.adoc
    │   │       ├── overview.adoc
    │   │       ├── sharp.adoc
    │   │       ├── staking.adoc
    │   │       ├── starkgate.adoc
    │   │       ├── state.adoc
    │   │       ├── strk.adoc
    │   │       └── transactions.adoc
    │   ├── archive/
    │   │   └── pages/
    │   │       ├── glossary.adoc
    │   │       ├── nodes.adoc
    │   │       ├── cairo-101/
    │   │       │   ├── arrays.adoc
    │   │       │   ├── booleans.adoc
    │   │       │   ├── constants.adoc
    │   │       │   ├── data-types.adoc
    │   │       │   ├── enums.adoc
    │   │       │   ├── felt.adoc
    │   │       │   ├── functions.adoc
    │   │       │   ├── if-expressions.adoc
    │   │       │   ├── integers.adoc
    │   │       │   ├── loops.adoc
    │   │       │   ├── strings.adoc
    │   │       │   ├── structs.adoc
    │   │       │   ├── tuples.adoc
    │   │       │   └── variables.adoc
    │   │       ├── ecosystem/
    │   │       │   ├── auditors-security-platforms.adoc
    │   │       │   ├── block-explorers-monitoring-tools.adoc
    │   │       │   ├── bridges-oracles.adoc
    │   │       │   ├── fullnodes-rpc-providers.adoc
    │   │       │   ├── indexers-enhanced-apis.adoc
    │   │       │   ├── open-rpc-endpoints-sepolia-faucets.adoc
    │   │       │   └── wallets-onramps.adoc
    │   │       ├── starknet-by-example/
    │   │       │   ├── calling_other_contracts.adoc
    │   │       │   ├── components-dependencies.adoc
    │   │       │   ├── components-storage-collisions.adoc
    │   │       │   ├── components.adoc
    │   │       │   ├── constructor.adoc
    │   │       │   ├── custom-types.adoc
    │   │       │   ├── documentation.adoc
    │   │       │   ├── errors.adoc
    │   │       │   ├── events.adoc
    │   │       │   ├── factory-pattern.adoc
    │   │       │   ├── hashing.adoc
    │   │       │   ├── interactions.adoc
    │   │       │   ├── library-calls.adoc
    │   │       │   ├── mappings.adoc
    │   │       │   ├── overview.adoc
    │   │       │   ├── storage-packing.adoc
    │   │       │   ├── storage.adoc
    │   │       │   ├── struct-mapping-key.adoc
    │   │       │   ├── testing.adoc
    │   │       │   ├── variables.adoc
    │   │       │   ├── visibility-mutability.adoc
    │   │       │   └── write-to-any-slot.adoc
    │   │       └── tools/
    │   │           ├── building-dapps.adoc
    │   │           ├── coding-in-cairo.adoc
    │   │           ├── creating-ai-agents.adoc
    │   │           ├── interacting-with-starknet.adoc
    │   │           ├── running-devnets.adoc
    │   │           └── writing-smart-contracts.adoc
    │   ├── ecosystem/
    │   │   ├── nav.adoc
    │   │   └── pages/
    │   │       └── overview.adoc
    │   ├── guides/
    │   │   ├── nav.adoc
    │   │   ├── pages/
    │   │   │   ├── becoming-a-validator/
    │   │   │   │   ├── juno.adoc
    │   │   │   │   ├── next-steps.adoc
    │   │   │   │   ├── overview.adoc
    │   │   │   │   ├── pathfinder.adoc
    │   │   │   │   ├── prerequisite.adoc
    │   │   │   │   └── stake.adoc
    │   │   │   └── quickstart/
    │   │   │       ├── devnet.adoc
    │   │   │       ├── environment-setup.adoc
    │   │   │       ├── hellostarknet.adoc
    │   │   │       ├── next-steps.adoc
    │   │   │       ├── overview.adoc
    │   │   │       ├── sepolia.adoc
    │   │   │       └── troubleshooting.adoc
    │   │   └── partials/
    │   │       └── snippet-important-troubleshooting.adoc
    │   ├── resources/
    │   │   ├── nav.adoc
    │   │   ├── pages/
    │   │   │   ├── chain-info.adoc
    │   │   │   ├── compatibility.adoc
    │   │   │   ├── messaging-reference.adoc
    │   │   │   ├── starkgate-reference.adoc
    │   │   │   ├── transactions-reference.adoc
    │   │   │   └── version-notes.adoc
    │   │   └── partials/
    │   │       ├── snippet_enrollTokenBridge_note.adoc
    │   │       ├── snippet_transaction_fields_master_table.adoc
    │   │       └── snippet_transaction_params.adoc
    │   ├── ROOT/
    │   │   ├── nav.adoc
    │   │   └── pages/
    │   │       └── index.adoc
    │   └── tools/
    │       ├── nav.adoc
    │       └── pages/
    │           └── overview.adoc
    └── .github/
        ├── PULL_REQUEST_TEMPLATE.md
        ├── ISSUE_TEMPLATE/
        │   ├── bug_report.md
        │   └── feature_request.md
        └── workflows/
            ├── algolia-indexing.yml
            ├── delete_preview.yml
            ├── pull_request.yml
            ├── push.yml
            └── tag.yml


Files Content:

(Files content cropped to 300k characters, download full ingest to see more)
================================================
FILE: README.adoc
================================================
[id="readme"]

= Starknet Docs

Welcome to the https://docs.starknet.io[Starknet Docs^] repository, written in https://asciidoc.org/[AsciiDoc^] and built using https://antora.org/[Antora^].

[NOTE]
====
This repository only contains the content of the Starknet Docs. For the UI, see the https://github.com/starknet-io/starknet-docs-ui/tree/main[Starknet Docs UI repository^].
====

To build and preview content locally, first:

. Install `yarn` if it's not already installed.
. Install `npx` if it's not already installed.
. Clone this repo, either from a fork or directly from `starknet-io/starknet-docs` (if you are an official collaborator).
. Navigate into the `starknet-docs` directory and run the `yarn` command to prepare the environment:
+
----
cd starknet-docs && yarn
----

Then:

. Build the content with Antora:
+
[source,bash]
----
npx antora playbook.yml
----
+
generating the website in the `public_html` directory.

. Run the http server packaged with Antora:
+
[source,bash]
----
npx http-server public_html -c-1
----
+
giving you one or more local URLs that you can use to view the website, e.g.:
+
[source,bash,subs="+quotes,+macros"]
----
Starting up http-server, serving *public_html*

...

Available on:
  \http://127.0.0.1:8080
  \http://192.168.68.111:8080
  \http://192.168.14.3:8080
  \http://10.14.0.2:8080
Hit CTRL-C to stop the server
----

After writing or editing content, rebuild it to preview your changes (rerunning the server is not necessary).



================================================
FILE: _typos.toml
================================================
[default]
check-file = false

[type.adoc]
extend-glob = ["*.adoc"]
check-file = true

[default.extend-words]
# Don't correct the word
afe = "afe"
Endur = "Endur"
Lazer = "Lazer"



================================================
FILE: antora.yml
================================================
name: ROOT
version: ~
title: Starknet
nav:
  - modules/ROOT/nav.adoc
  - modules/guides/nav.adoc
  - modules/architecture/nav.adoc
  - modules/tools/nav.adoc
  - modules/ecosystem/nav.adoc
  - modules/resources/nav.adoc


================================================
FILE: lunr-tokenizer.js
================================================
// The tokenization used by lunr by default doesn't work well with code.
// We extend the set of characters considered separators to include
// parentheses and commas.

module.exports.register = () => {
  const lunr = require('lunr');
  lunr.tokenizer.separator = /[\s\-(),]+/;
};



================================================
FILE: package.json
================================================
{
  "name": "starknet-docs",
  "version": "0.1.514",
  "private": true,
  "scripts": {
    "pre-release": "standard-version --prerelease --skip.changelog --releaseCommitMessageFormat 'chore(prerelease): {{currentTag}}'",
    "release": "standard-version",
    "release:dry": "standard-version --dry-run",
    "generate": "antora playbook.yml"
  },
  "devDependencies": {
    "@antora/cli": "3.1.1",
    "@antora/site-generator": "3.1.1"
  },
  "dependencies": {
    "@antora/lunr-extension": "^1.0.0-alpha.8",
    "@asciidoctor/tabs": "^1.0.0-beta.3",
    "algoliasearch": "^4.14.2",
    "asciidoctor": "^2.2.6",
    "html-to-text": "^8.2.1",
    "lunr": "^2.3.9",
    "simple-git": "^3.15.0",
    "standard-version": "^9.3.2"
  }
}



================================================
FILE: playbook.yml
================================================
site:
  title: Starknet documentation
  url: https://docs.starknet.io/
  start_page: ROOT::index.adoc
  keys:
    google_analytics: 'G-WY42TERK5P'
urls:
  html_extension_style: indexify

content:
  sources:
    - url: .
      branches: HEAD
      edit_url: 'https://github.com/starknet-io/starknet-docs/edit/main/{path}'

ui:
  bundle:
    url: https://github.com/starknet-io/starknet-docs-ui/raw/HEAD/build/ui-bundle.zip
    snapshot: true

runtime:
  fetch: true

asciidoc:
  extensions:
    - '@asciidoctor/tabs'
  attributes:
    idprefix: ''
    #stem: '@'
    stem: 'latexmath'
    page-pagination: ''
    experimental: ''

antora:
  extensions:
    - require: './lunr-tokenizer'
    - require: '@antora/lunr-extension'
      index_latest_only: true

output:
  destinations:
    - provider: fs
      path: ./public_html/
      clean: true



================================================
FILE: .htaccess
================================================
ErrorDocument 404 /404.html
<IfModule mod_headers.c>
    Header set Cache-Control "no-cache, no-store, must-revalidate"
    Header set Pragma "no-cache"
    Header set Expires 0
</IfModule>
RewriteEngine on
RewriteRule ^docs/$ /documentation? [R=301,L]
RewriteRule ^docs/$ /documentation? [R=301,L]
RewriteRule ^docs/Blocks/header/$ /documentation/architecture_and_concepts/Network_Architecture/header? [R=301,L]
RewriteRule ^documentation/develop/Blocks/header/$ /documentation/architecture_and_concepts/Network_Architecture/header? [R=301,L]
RewriteRule ^docs/Blocks/header/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/header? [R=301,L]
RewriteRule ^/develop/Blocks/header/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/header? [R=301,L]
RewriteRule ^docs/Blocks/transaction\-life\-cycle/$ /documentation/architecture_and_concepts/Network_Architecture/transaction-life-cycle? [R=301,L]
RewriteRule ^/develop/Blocks/transaction\-life\-cycle/$ /documentation/architecture_and_concepts/Network_Architecture/transaction-life-cycle? [R=301,L]
RewriteRule ^docs/Blocks/transaction\-life\-cycle/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/transaction-life-cycle? [R=301,L]
RewriteRule ^/develop/Blocks/transaction\-life\-cycle/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/transaction-life-cycle? [R=301,L]
RewriteRule ^docs/Blocks/transactions/$ /documentation/architecture_and_concepts/Network_Architecture/transactions? [R=301,L]
RewriteRule ^/develop/Blocks/transactions/$ /documentation/architecture_and_concepts/Network_Architecture/transactions? [R=301,L]
RewriteRule ^docs/Blocks/transactions/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/transactions? [R=301,L]
RewriteRule ^/develop/Blocks/transactions/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/transactions? [R=301,L]
RewriteRule ^docs/CLI/commands/$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^/develop/CLI/commands/$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^docs/CLI/commands/index\.html$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^/develop/CLI/commands/index\.html$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^docs/Contracts/contract\-abi/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-abi? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-abi/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-abi? [R=301,L]
RewriteRule ^docs/Contracts/contract\-abi/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-abi? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-abi/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-abi? [R=301,L]
RewriteRule ^docs/Contracts/contract\-address/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-address? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-address/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-address? [R=301,L]
RewriteRule ^docs/Contracts/contract\-address/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-address? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-address/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-address? [R=301,L]
RewriteRule ^docs/Contracts/contract\-classes/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-classes? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-classes/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-classes? [R=301,L]
RewriteRule ^docs/Contracts/contract\-classes/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-classes? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-classes/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-classes? [R=301,L]
RewriteRule ^docs/Contracts/contract\-hash/$ /documentation/architecture_and_concepts/Smart_Contracts/class-hash? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-hash/$ /documentation/architecture_and_concepts/Smart_Contracts/class-hash? [R=301,L]
RewriteRule ^docs/Contracts/contract\-hash/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/class-hash? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-hash/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/class-hash? [R=301,L]
RewriteRule ^docs/Contracts/contract\-storage/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-storage? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-storage/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-storage? [R=301,L]
RewriteRule ^docs/Contracts/contract\-storage/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-storage? [R=301,L]
RewriteRule ^/develop/Contracts/contract\-storage/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-storage? [R=301,L]
RewriteRule ^docs/Data\ Availabilty/on\-chain\-data/$ /documentation/architecture_and_concepts/Network_Architecture/on-chain-data? [R=301,L]
RewriteRule ^/develop/Data_Availabilty/on\-chain-data/$ /documentation/architecture_and_concepts/Network_Architecture/on-chain-data? [R=301,L]
RewriteRule ^docs/Data\ Availabilty/on\-chain\-data/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/on-chain-data? [R=301,L]
RewriteRule ^/develop/Data_Availabilty/on\-chain\-data/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/on-chain-data? [R=301,L]
RewriteRule ^docs/Events/starknet\-events/$ /documentation/architecture_and_concepts/Smart_Contracts/starknet-events? [R=301,L]
RewriteRule ^/develop/Events/starknet\-events/$ /documentation/architecture_and_concepts/Smart_Contracts/starknet-events? [R=301,L]
RewriteRule ^docs/Events/starknet\-events/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/starknet-events? [R=301,L]
RewriteRule ^/develop/Events/starknet\-events/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/starknet-events? [R=301,L]
RewriteRule ^docs/Fees/fee\-mechanism/$ /documentation/architecture_and_concepts/Network_Architecture/fee-mechanism? [R=301,L]
RewriteRule ^/develop/Fees/fee\-mechanism/$ /documentation/architecture_and_concepts/Network_Architecture/fee-mechanism? [R=301,L]
RewriteRule ^docs/Fees/fee\-mechanism/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/fee-mechanism? [R=301,L]
RewriteRule ^/develop/Fees/fee\-mechanism/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/fee-mechanism? [R=301,L]
RewriteRule ^docs/Hashing/hash\-functions/$ /documentation/architecture_and_concepts/Cryptography/hash-functions? [R=301,L]
RewriteRule ^/develop/Hashing/hash\-functions/$ /documentation/architecture_and_concepts/Cryptography/hash-functions? [R=301,L]
RewriteRule ^docs/Hashing/hash\-functions/index\.html$ /documentation/architecture_and_concepts/Cryptography/hash-functions? [R=301,L]
RewriteRule ^/develop/Hashing/hash\-functions/index\.html$ /documentation/architecture_and_concepts/Cryptography/hash-functions? [R=301,L]
RewriteRule ^docs/intro/$ /documentation? [R=301,L]
RewriteRule ^docs/intro/index\.html$ /documentation? [R=301,L]
RewriteRule ^docs/L1\-L2\ Communication/messaging\-mechanism/$ /documentation/architecture_and_concepts/Network_Architecture/messaging-mechanism? [R=301,L]
RewriteRule ^/develop/L1\-L2_Communication/messaging\-mechanism/$ /documentation/architecture_and_concepts/Network_Architecture/messaging-mechanism? [R=301,L]
RewriteRule ^docs/L1\-L2\ Communication/messaging\-mechanism/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/messaging-mechanism? [R=301,L]
RewriteRule ^/develop/L1\-L2_Communication/messaging\-mechanism/index\.html$$ /documentation/architecture_and_concepts/Network_Architecture/messaging-mechanism? [R=301,L]
RewriteRule ^docs/L1\-L2\ Communication/token\-bridge/$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^/develop/L1\-L2_Communication/token\-bridge/$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^documentation/develop/L1\-L2_Communication/token\-bridge\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^docs/L1\-L2\ Communication/token\-bridge/index\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^/develop/L1\-L2_Communication/token\-bridge/index\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^docs/L1\<\>L2\ Communication/token\-bridge/$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^/develop/L1\-L2_Communication/token\-bridge/$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^docs/L1\<\>L2\ Communication/token\-bridge/index\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^/develop/L1\-L2_Communication/token\-bridge/index\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^docs/State/starknet\-state/$ /documentation/architecture_and_concepts/Network_Architecture/starknet-state? [R=301,L]
RewriteRule ^/develop/State/starknet\-state/$ /documentation/architecture_and_concepts/Network_Architecture/starknet-state? [R=301,L]
RewriteRule ^docs/State/starknet\-state/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/starknet-state? [R=301,L]
RewriteRule ^/develop/State/starknet\-state/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/starknet-state? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Blocks/header/$ /documentation/architecture_and_concepts/Network_Architecture/header? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Blocks/header/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/header? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Blocks/transaction\-life\-cycle/$ /documentation/architecture_and_concepts/Network_Architecture/transaction-life-cycle? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Blocks/transaction\-life\-cycle/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/transaction-life-cycle? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Blocks/transactions/$ /documentation/architecture_and_concepts/Network_Architecture/transactions? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Blocks/transactions/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/transactions? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Fees/fee\-mechanism/$ /documentation/architecture_and_concepts/Network_Architecture/fee-mechanism? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Fees/fee\-mechanism/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/fee-mechanism? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/L1\-L2_Communication/token\-bridge/$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/L1\-L2_Communication/token\-bridge/index\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/token\-bridge/$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/token\-bridge/index.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/L1\-L2_Communication/messaging\-mechanism/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/messaging-mechanism? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/L1\-L2_Communication/messaging\-mechanism/$ /documentation/architecture_and_concepts/Network_Architecture/messaging-mechanism? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Events/starknet\-events/$ /documentation/architecture_and_concepts/Smart_Contracts/starknet-events? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Events/starknet\-events/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/starknet-events? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Data_Availability/on\-chain\-data/$ /documentation/architecture_and_concepts/Network_Architecture/on-chain-data? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Data_Availability/on\-chain\-data/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/on-chain-data? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/State/starknet\-state/$ /documentation/architecture_and_concepts/Network_Architecture/starknet-state? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/State/starknet\-state/index\.html$ /documentation/architecture_and_concepts/Network_Architecture/starknet-state? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/class\-hash/$ /documentation/architecture_and_concepts/Smart_Contracts/class-hash? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/class\-hash/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/class-hash? [R=301,L]
RewriteRule ^documentation/develop/L1\-L2_Communication/token\-bridge\.html$ /documentation/tools/starkgate-bridge? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Hashing/hash\-functions/$ /documentation/architecture_and_concepts/Cryptography/hash-functions? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Hashing/hash\-functions/index\.html$ /documentation/architecture_and_concepts/Cryptography/hash-functions? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/system\-calls\-cairo1$ /documentation/architecture_and_concepts/Smart_Contracts/system-calls-cairo1? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/system\-calls\-cairo1/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/system-calls-cairo1? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/system\-calls\-cairo0$ /documentation/architecture_and_concepts/Smart_Contracts/system-calls-cairo1? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/system\-calls\-cairo0/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/system-calls-cairo1? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cairo_on_Starknet/cairo\-1\-and\-sierra/$ /documentation/architecture_and_concepts/Smart_Contracts/cairo-and-sierra? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cairo_on_Starknet/cairo\-1\-and\-sierra/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/cairo-and-sierra? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cairo_on_Starknet/contract\-syntax/$ /documentation/architecture_and_concepts/Smart_Contracts/contract-syntax? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cairo_on_Starknet/contract\-syntax/index\.html$ /documentation/architecture_and_concepts/Smart_Contracts/contract-syntax? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/validate_and_execute/index\.html$ /documentation/architecture_and_concepts/Accounts/account_functions? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/validate_and_execute/$ /documentation/architecture_and_concepts/Accounts/account_functions? [R=301,L]
RewriteRule ^documentation/getting_started/environment_setup/$ /documentation/quick_start/environment_setup? [R=301,L]
RewriteRule ^documentation/getting_started/environment_setup/index\.html$ /documentation/quick_start/environment_setup? [R=301,L]
RewriteRule ^documentation/getting_started/account_setup/$ /documentation/quick_start/set_up_an_account? [R=301,L]
RewriteRule ^documentation/getting_started/account_setup/index\.html$ /documentation/quick_start/set_up_an_account? [R=301,L]
RewriteRule ^documentation/tools/CLI/starkli/$ /documentation/tools/devtools/? [R=301,L]
RewriteRule ^documentation/tools/CLI/starkli/index\.html$ /documentation/tools/devtools/? [R=301,L]
RewriteRule ^documentation/tools/CLI/commands/$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^documentation/tools/CLI/commands/index\.html$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^documentation/cli/commands/$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^documentation/cli/commands/index\.html$ /documentation/cli/starkli? [R=301,L]
RewriteRule ^documentation/tools/api_rpc/$ /documentation/tools/api-services? [R=301,L]
RewriteRule ^documentation/tools/api_rpc/index\.html$ /documentation/tools/api-services? [R=301,L]
RewriteRule ^documentation/api/api\-reference/$ /documentation/tools/api-services? [R=301,L]
RewriteRule ^documentation/api/api\-reference/index\.html$ /documentation/tools/api-services? [R=301,L]
RewriteRule ^documentation/contribute/bug\-bounty/index\.html$ /documentation? [R=301,L]
RewriteRule ^documentation/contribute/bug\-bounty/$ /documentation? [R=301,L]
RewriteRule ^documentation/contribute/completed\-audits/$ /documentation? [R=301,L]
RewriteRule ^documentation/contribute/completed\-audits/index\.html$ /documentation? [R=301,L]
RewriteRule ^documentation/contribute/conduct/$ /documentation? [R=301,L]
RewriteRule ^documentation/contribute/conduct/index\.html$ /documentation? [R=301,L]
RewriteRule ^docs/Blocks/transactions/$ /documentation/architecture_and_concepts/Network_Architecture/transactions/? [R=301,L]
RewriteRule ^docs/Blocks/transactions$ /documentation/architecture_and_concepts/Network_Architecture/transactions/? [R=301,L]
RewriteRule ^documentation/$ /? [R=301,L]
RewriteRule ^documentation/index\.html$ /index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/account_functions/$ /architecture-and-concepts/accounts/account-functions/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/account_functions/index\.html$ /architecture-and-concepts/accounts/account-functions/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/approach/$ /architecture-and-concepts/accounts/approach/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/approach/index\.html$ /architecture-and-concepts/accounts/approach/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/deploying_new_accounts/$ /architecture-and-concepts/accounts/deploying-new-accounts/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/deploying_new_accounts/index\.html$ /architecture-and-concepts/accounts/deploying-new-accounts/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/introduction/$ /architecture-and-concepts/accounts/introduction/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/introduction/index\.html$ /architecture-and-concepts/accounts/introduction/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/simplified_transaction_flow/$ /architecture-and-concepts/accounts/simplified-transaction-flow/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/simplified_transaction_flow/index\.html$ /architecture-and-concepts/accounts/simplified-transaction-flow/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/universal\-deployer/$ /architecture-and-concepts/accounts/universal-deployer/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Accounts/universal\-deployer/index\.html$ /architecture-and-concepts/accounts/universal-deployer/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cryptography/hash\-functions/$ /architecture-and-concepts/cryptography/hash-functions/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cryptography/hash\-functions/index\.html$ /architecture-and-concepts/cryptography/hash-functions/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cryptography/p\-value/$ /architecture-and-concepts/cryptography/p-value/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cryptography/p\-value/index\.html$ /architecture-and-concepts/cryptography/p-value/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cryptography/stark\-curve/$ /architecture-and-concepts/cryptography/stark-curve/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Cryptography/stark\-curve/index\.html$ /architecture-and-concepts/cryptography/stark-curve/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Economics\-of\-Starknet/$ /architecture-and-concepts/economics-of-starknet/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Economics\-of\-Starknet/index\.html$ /architecture-and-concepts/economics-of-starknet/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/fee\-mechanism/$ /architecture-and-concepts/network-architecture/fee-mechanism/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/fee\-mechanism/index\.html$ /architecture-and-concepts/network-architecture/fee-mechanism/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/header/$ /architecture-and-concepts/network-architecture/block-structure/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/header/index\.html$ /architecture-and-concepts/network-architecture/block-structure/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/messaging\-mechanism/$ /architecture-and-concepts/network-architecture/messaging-mechanism/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/messaging\-mechanism/index\.html$ /architecture-and-concepts/network-architecture/messaging-mechanism/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/on\-chain\-data/$ /architecture-and-concepts/network-architecture/data-availability/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/on\-chain\-data/index\.html$ /architecture-and-concepts/network-architecture/data-availability/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/starknet_architecture_overview/$ /architecture-and-concepts/network-architecture/starknet-architecture-overview/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/starknet_architecture_overview/index\.html$ /architecture-and-concepts/network-architecture/starknet-architecture-overview/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/starknet\-state/$ /architecture-and-concepts/network-architecture/starknet-state/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/starknet\-state/index\.html$ /architecture-and-concepts/network-architecture/starknet-state/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/transaction\-life\-cycle/$ /architecture-and-concepts/network-architecture/transaction-life-cycle/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/transaction\-life\-cycle/index\.html$ /architecture-and-concepts/network-architecture/transaction-life-cycle/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/transactions/$ /architecture-and-concepts/network-architecture/transactions/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/transactions/index\.html$ /architecture-and-concepts/network-architecture/transactions/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/cairo\-and\-sierra/$ /architecture-and-concepts/smart-contracts/cairo-and-sierra/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/cairo\-and\-sierra/index\.html$ /architecture-and-concepts/smart-contracts/cairo-and-sierra/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/cairo\-builtins/$ /architecture-and-concepts/smart-contracts/cairo-builtins/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/cairo\-builtins/index\.html$ /architecture-and-concepts/smart-contracts/cairo-builtins/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/class\-hash/$ /architecture-and-concepts/smart-contracts/class-hash/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/class\-hash/index\.html$ /architecture-and-concepts/smart-contracts/class-hash/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-abi/$ /architecture-and-concepts/smart-contracts/contract-abi/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-abi/index\.html$ /architecture-and-concepts/smart-contracts/contract-abi/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-address/$ /architecture-and-concepts/smart-contracts/contract-address/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-address/index\.html$ /architecture-and-concepts/smart-contracts/contract-address/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-classes/$ /architecture-and-concepts/smart-contracts/contract-classes/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-classes/index\.html$ /architecture-and-concepts/smart-contracts/contract-classes/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-storage/$ /architecture-and-concepts/smart-contracts/contract-storage/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-storage/index\.html$ /architecture-and-concepts/smart-contracts/contract-storage/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-syntax/$ /architecture-and-concepts/smart-contracts/contract-syntax/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/contract\-syntax/index\.html$ /architecture-and-concepts/smart-contracts/contract-syntax/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/execution_info/$ /architecture-and-concepts/smart-contracts/execution-info/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/execution_info/index\.html$ /architecture-and-concepts/smart-contracts/execution-info/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/serialization_of_Cairo_types/$ /architecture-and-concepts/smart-contracts/serialization-of-cairo-types/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/serialization_of_Cairo_types/index\.html$ /architecture-and-concepts/smart-contracts/serialization-of-cairo-types/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/starknet\-events/$ /architecture-and-concepts/smart-contracts/starknet-events/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/starknet\-events/index\.html$ /architecture-and-concepts/smart-contracts/starknet-events/index.html? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/system\-calls\-cairo1/$ /architecture-and-concepts/smart-contracts/system-calls-cairo1/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/system\-calls\-cairo1/index\.html$ /architecture-and-concepts/smart-contracts/system-calls-cairo1/index.html? [R=301,L]
RewriteRule ^documentation/cli/starkli/$ /cli/starkli/? [R=301,L]
RewriteRule ^documentation/cli/starkli/index\.html$ /cli/starkli/index.html? [R=301,L]
RewriteRule ^documentation/cli/starknet\-compiler\-options/$ /cli/starknet-compiler-options/? [R=301,L]
RewriteRule ^documentation/cli/starknet\-compiler\-options/index\.html$ /cli/starknet-compiler-options/index.html? [R=301,L]
RewriteRule ^documentation/glossary/$ /glossary/? [R=301,L]
RewriteRule ^documentation/glossary/index\.html$ /glossary/index.html? [R=301,L]
RewriteRule ^documentation/notational\-conventions/$ /notational-conventions/? [R=301,L]
RewriteRule ^documentation/notational\-conventions/index\.html$ /notational-conventions/index.html? [R=301,L]
RewriteRule ^documentation/quick_start/declare_a_smart_contract/$ /quick-start/declare-a-smart-contract/? [R=301,L]
RewriteRule ^documentation/quick_start/declare_a_smart_contract/index\.html$ /quick-start/declare-a-smart-contract/index.html? [R=301,L]
RewriteRule ^documentation/quick_start/deploy_a_smart_contract/$ /quick-start/deploy-a-smart-contract/? [R=301,L]
RewriteRule ^documentation/quick_start/deploy_a_smart_contract/index\.html$ /quick-start/deploy-a-smart-contract/index.html? [R=301,L]
RewriteRule ^documentation/quick_start/environment_setup/$ /quick-start/environment-setup/? [R=301,L]
RewriteRule ^documentation/quick_start/environment_setup/index\.html$ /quick-start/environment-setup/index.html? [R=301,L]
RewriteRule ^documentation/quick_start/interact_with_a_smart_contract/$ /quick-start/interact-with-a-smart-contract/? [R=301,L]
RewriteRule ^documentation/quick_start/interact_with_a_smart_contract/index\.html$ /quick-start/interact-with-a-smart-contract/index.html? [R=301,L]
RewriteRule ^documentation/quick_start/set_up_an_account/$ /quick-start/set-up-an-account/? [R=301,L]
RewriteRule ^documentation/quick_start/set_up_an_account/index\.html$ /quick-start/set-up-an-account/index.html? [R=301,L]
RewriteRule ^documentation/starknet_versions/deprecated/$ /starknet-versions/deprecated/? [R=301,L]
RewriteRule ^documentation/starknet_versions/deprecated/index\.html$ /starknet-versions/deprecated/index.html? [R=301,L]
RewriteRule ^documentation/starknet_versions/juno_versions/$ /starknet-versions/juno-versions/? [R=301,L]
RewriteRule ^documentation/starknet_versions/juno_versions/index\.html$ /starknet-versions/juno-versions/index.html? [R=301,L]
RewriteRule ^documentation/starknet_versions/pathfinder_versions/$ /starknet-versions/pathfinder-versions/? [R=301,L]
RewriteRule ^documentation/starknet_versions/pathfinder_versions/index\.html$ /starknet-versions/pathfinder-versions/index.html? [R=301,L]
RewriteRule ^documentation/starknet_versions/upcoming_versions/$ /starknet-versions/upcoming-versions/? [R=301,L]
RewriteRule ^documentation/starknet_versions/upcoming_versions/index\.html$ /starknet-versions/upcoming-versions/index.html? [R=301,L]
RewriteRule ^documentation/starknet_versions/version_notes/$ /starknet-versions/version-notes/? [R=301,L]
RewriteRule ^documentation/starknet_versions/version_notes/index\.html$ /starknet-versions/version-notes/index.html? [R=301,L]
RewriteRule ^documentation/tools/api\-services/$ /tools/api-services/? [R=301,L]
RewriteRule ^documentation/tools/api\-services/index\.html$ /tools/api-services/index.html? [R=301,L]
RewriteRule ^documentation/tools/audit/$ /tools/audit/? [R=301,L]
RewriteRule ^documentation/tools/audit/index\.html$ /tools/audit/index.html? [R=301,L]
RewriteRule ^documentation/tools/bridged_tokens/$ /tools/bridged-tokens/? [R=301,L]
RewriteRule ^documentation/tools/bridged_tokens/index\.html$ /tools/bridged-tokens/index.html? [R=301,L]
RewriteRule ^documentation/tools/dai_token_migration/$ /tools/dai-token-migration/? [R=301,L]
RewriteRule ^documentation/tools/dai_token_migration/index\.html$ /tools/dai-token-migration/index.html? [R=301,L]
RewriteRule ^documentation/tools/devtools/$ /tools/devtools/? [R=301,L]
RewriteRule ^documentation/tools/devtools/index\.html$ /tools/devtools/index.html? [R=301,L]
RewriteRule ^documentation/tools/important_addresses/$ /tools/important-addresses/? [R=301,L]
RewriteRule ^documentation/tools/important_addresses/index\.html$ /tools/important-addresses/index.html? [R=301,L]
RewriteRule ^documentation/tools/limits_and_triggers/$ /tools/limits-and-triggers/? [R=301,L]
RewriteRule ^documentation/tools/limits_and_triggers/index\.html$ /tools/limits-and-triggers/index.html? [R=301,L]
RewriteRule ^documentation/tools/ref_block_explorers/$ /tools/ref-block-explorers/? [R=301,L]
RewriteRule ^documentation/tools/ref_block_explorers/index\.html$ /tools/ref-block-explorers/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-adding_a_token/$ /starkgate/adding-a-token/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-adding_a_token/index\.html$ /starkgate/adding-a-token/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate_architecture/$ /starkgate/architecture/? [R=301,L]
RewriteRule ^documentation/tools/starkgate_architecture/index\.html$ /starkgate/architecture/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-automated_actions_with_bridging/$ /starkgate/automated-actions-with-bridging/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-automated_actions_with_bridging/index\.html$ /starkgate/automated-actions-with-bridging/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-bridge/$ /starkgate/overview/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-bridge/index\.html$ /starkgate/overview/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-cancelling\ a\ deposit/$ /starkgate/cancelling-a-deposit/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-cancelling\ a\ deposit/index\.html$ /starkgate/cancelling-a-deposit/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-depositing/$ /starkgate/depositing/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-depositing/index\.html$ /starkgate/depositing/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-estimating_fees/$ /starkgate/estimating-fees/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-estimating_fees/index\.html$ /starkgate/estimating-fees/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate_function_reference/$ /starkgate/function-reference/? [R=301,L]
RewriteRule ^documentation/tools/starkgate_function_reference/index\.html$ /starkgate/function-reference/index.html? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-withdrawing/$ /starkgate/withdrawing/? [R=301,L]
RewriteRule ^documentation/tools/starkgate\-withdrawing/index\.html$ /starkgate/withdrawing/index.html? [R=301,L]
RewriteRule ^documentation/tools/starknet\-book/$ /tools/starknet-book/? [R=301,L]
RewriteRule ^documentation/tools/starknet\-book/index\.html$ /tools/starknet-book/index.html? [R=301,L]
RewriteRule ^docs/intro$ /? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Account_Abstraction/introduction/$ /architecture-and-concepts/accounts/introduction/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/contract\-classes/$ /architecture-and-concepts/smart-contracts/contract-classes/? [R=301,L]
RewriteRule ^documentation/useful_info/$ /tools/important-addresses/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/system\-calls\-cairo1/$ /architecture-and-concepts/smart-contracts/system-calls-cairo1/? [R=301,L]
RewriteRule ^docs/L1\-L2\ Communication/messaging\-mechanism$ /architecture-and-concepts/network-architecture/messaging-mechanism/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/contract\-storage/$ /architecture-and-concepts/smart-contracts/contract-storage/? [R=301,L]
RewriteRule ^docs/Blocks/transactions$ /architecture-and-concepts/network-architecture/transactions/? [R=301,L]
RewriteRule ^documentation/develop/Blocks/transactions/$ /architecture-and-concepts/network-architecture/transactions/? [R=301,L]
RewriteRule ^documentation/getting_started/$ /quick-start/environment-setup/? [R=301,L]
RewriteRule ^docs/CLI/commands$ /cli/starkli/? [R=301,L]
RewriteRule ^docs/Fees/fee\-mechanism$ /architecture-and-concepts/network-architecture/fee-mechanism/? [R=301,L]
RewriteRule ^docs/L1\<\>L2\ Communication/token\-bridge$ /starkgate/overview/? [R=301,L]
RewriteRule ^documentation/architecture$ /architecture-and-concepts/network-architecture/starknet-architecture-overview/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/contract\-address/$ /architecture-and-concepts/smart-contracts/contract-address/? [R=301,L]
RewriteRule ^documentation/develop/State/starknet\-state/$ /architecture-and-concepts/network-architecture/starknet-state/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Account_Abstraction/approach/$ /architecture-and-concepts/accounts/approach/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/contract\-abi/$ /architecture-and-concepts/smart-contracts/contract-abi/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/Blocks/transactions/$ /architecture-and-concepts/network-architecture/transactions/? [R=301,L]
RewriteRule ^documentation/transaction\-structure\-and\-hash/$ /architecture-and-concepts/network-architecture/transactions/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/L1\-L2_Communication/token\-bridge/$ /starkgate/overview/? [R=301,L]
RewriteRule ^documentation/develop/Hashing/hash\-functions$ /architecture-and-concepts/cryptography/hash-functions/? [R=301,L]
RewriteRule ^documentation/develop/Hashing/hash\-functions/$ /architecture-and-concepts/cryptography/hash-functions/? [R=301,L]
RewriteRule ^docs/Contracts/contract\-address$ /architecture-and-concepts/smart-contracts/contract-address/? [R=301,L]
RewriteRule ^docs/Hashing/hash\-functions$ /architecture-and-concepts/cryptography/hash-functions/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Account_Abstraction/validate_and_execute/$ /architecture-and-concepts/accounts/account-functions/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/cairo\-1\-and\-sierra/$ /architecture-and-concepts/smart-contracts/cairo-and-sierra/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Contracts/system\-calls/$ /architecture-and-concepts/smart-contracts/system-calls-cairo1/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/Blocks/header/$ /architecture-and-concepts/network-architecture/block-structure/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/Data_Availability/on\-chain\-data/$ /architecture-and-concepts/network-architecture/data-availability/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/Fees/fee\-mechanism/$ /architecture-and-concepts/network-architecture/fee-mechanism/? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Network_Architecture/L1\-L2_Communication/messaging\-mechanism/$ /architecture-and-concepts/network-architecture/messaging-mechanism/? [R=301,L]
RewriteRule ^documentation/getting_started/setting_up_the_environment/$ /quick-start/environment-setup/? [R=301,L]
RewriteRule ^documentation/getting_started/unit_tests/$ /quick-start/environment-setup/? [R=301,L]
RewriteRule ^documentation/tools/CLI/starknet\-compiler\-options/$ /cli/starknet-compiler-options/? [R=301,L]
RewriteRule ^tools/starknet\-book/$ /? [R=301,L]
RewriteRule ^tools/devtools/clis/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/sdks/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/dapp-frameworks/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/libs-for-dapps/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/devnets/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/smart-contract-tools/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/vscode/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/utilities/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/devtools/security/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^documentation/architecture_and_concepts/Smart_Contracts/system-calls/$ /architecture-and-concepts/smart-contracts/system-calls-cairo1/? [R=301,L]
RewriteRule ^quick-start/declare-a-smart-contract/$ /quick-start/overview/? [R=301,L]
RewriteRule ^quick-start/deploy-a-smart-contract/$ /quick-start/overview/? [R=301,L]
RewriteRule ^quick-start/interact-with-a-smart-contract/$ /quick-start/overview/? [R=301,L]
RewriteRule ^quick-start/set-up-an-account/$ /quick-start/overview/? [R=301,L]
RewriteRule ^quick-start/deploy-interact-with-a-smart-contract-remix/$ /quick-start/overview/? [R=301,L]
RewriteRule ^quick-start/using_devnet/$ /quick-start/devnet/? [R=301,L]
RewriteRule ^documentation/tools/limits_and_triggers/$ /tools/limits-and-triggers/? [R=301,L]
RewriteRule ^tools/limits-and-triggers/$ /chain-info/? [R=301,L]
RewriteRule ^tools/important-addresses/$ /chain-info/? [R=301,L]
RewriteRule ^starknet-versions/deprecated/$ /chain-info/? [R=301,L]
RewriteRule ^architecture-and-concepts/cryptography/p-value/$ /architecture-and-concepts/cryptography? [R=301,L]
RewriteRule ^architecture-and-concepts/cryptography/stark-curve/$ /architecture-and-concepts/cryptography? [R=301,L]
RewriteRule ^architecture-and-concepts/cryptography/hash-functions/$ /architecture-and-concepts/cryptography? [R=301,L]
RewriteRule ^starkgate/adding-a-token/$ /starkgate/overview? [R=301,L]
RewriteRule ^starkgate/estimating-fees/$ /starkgate/overview? [R=301,L]
RewriteRule ^notational-conventions/$ /? [R=301,L]
RewriteRule ^cli/starkli/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^cli/starknet-compiler-options/$ /tools/devtools/overview? [R=301,L]
RewriteRule ^tools/api-services/$ /tools/fullnodes-rpc-providers? [R=301,L]
RewriteRule ^tools/ref-block-explorers/$ /tools/block-explorers-monitoring-tools? [R=301,L]
RewriteRule ^tools/data-indexers/$ /tools/indexers-enhanced-api-providers? [R=301,L]
RewriteRule ^tools/oracles/$ /tools/oracles-faucets? [R=301,L]
RewriteRule ^tools/indexers-enhanced-api-providers/$ /tools/indexers-enhanced-apis? [R=301,L]
RewriteRule ^starknet-versions/juno-versions/$ /? [R=301,L]
RewriteRule ^starknet-versions/pathfinder-versions/$ /? [R=301,L]
RewriteRule ^starknet-versions/upcoming-versions/$ /starknet-versions/version-notes? [R=301,L]
RewriteRule ^tools/audit/$ /ecosystem/auditors-security-platforms? [R=301,L]
RewriteRule ^tools/block-explorers-monitoring-tools/$ /ecosystem/block-explorers-monitoring-tools? [R=301,L]
RewriteRule ^tools/bridged-tokens/$ /? [R=301,L]
RewriteRule ^tools/dai-token-migration/$ /starkgate/troubleshooting/? [R=301,L]
RewriteRule ^tools/fullnodes-rpc-providers/$ /ecosystem/fullnodes-rpc-providers? [R=301,L]
RewriteRule ^tools/indexers-enhanced-apis/$ /ecosystem/indexers-enhanced-apis? [R=301,L]
RewriteRule ^tools/oracles-faucets/$ /ecosystem/overview? [R=301,L]
RewriteRule ^tools/starknet-book/$ /? [R=301,L]
RewriteRule ^tools/devtools/building-dapps/$ /tools/building-dapps? [R=301,L]
RewriteRule ^tools/devtools/coding-in-cairo/$ /tools/coding-in-cairo? [R=301,L]
RewriteRule ^tools/devtools/creating-ai-agents/$ /tools/creating-ai-agents? [R=301,L]
RewriteRule ^tools/devtools/interacting-with-starknet/$ /tools/interacting-with-starknet? [R=301,L]
RewriteRule ^tools/devtools/overview/$ /tools/overview? [R=301,L]
RewriteRule ^tools/devtools/running-devnets/$ /tools/running-devnets? [R=301,L]
RewriteRule ^tools/devtools/writing-smart-contracts/$ /tools/writing-smart-contracts? [R=301,L]
RewriteRule ^chain-info/$ /resources/chain-info? [R=301,L]
RewriteRule ^glossary/$ /resources/glossary? [R=301,L]
RewriteRule ^starknet-versions/version-notes /resources/version-notes? [R=301,L]
RewriteRule ^starknet-versions/juno-versions/$ /? [R=301,L]
RewriteRule ^starknet-versions/pathfinder-versions/$ /? [R=301,L]
RewriteRule ^starknet-versions/upcoming-versions/$ /? [R=301,L]
RewriteRule ^quick-start/$ /quick-start/overview? [R=301,L]
RewriteRule ^staking/$ /staking/overview? [R=301,L]
RewriteRule ^starkgate/$ /starkgate/overview? [R=301,L]
RewriteRule ^starkgate/$ /starkgate/overview? [R=301,L]
RewriteRule ^tools/$ /tools/overview? [R=301,L]
RewriteRule ^ecosystem/$ /ecosystem/overview? [R=301,L]
RewriteRule ^resources/$ /resources/overview? [R=301,L]
RewriteRule ^quick-start/compiling-hellostarknet/$ /quick-start/hellostarknet? [R=301,L]
RewriteRule ^staking/architecture/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/architecture/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/claiming-rewards/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/delegating-stake/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/entering-staking/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/exiting-staking/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/increasing-staking/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/managing-staking-and-delegation-operations/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/switching-delegation-pools/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/staking-events-and-read-functions/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^staking/overview/$ /architecture-and-concepts/staking? [R=301,L]
RewriteRule ^architecture-and-concepts/provers-overview/$ /architecture-and-concepts/sharp? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/contract-storage/$ https://book.cairo-lang.org/ch101-01-00-contract-storage.html? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/contract-abi/$ https://book.cairo-lang.org/ch102-01-contract-class-abi.html? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/cairo-builtins/$ https://book.cairo-lang.org/ch204-00-builtins.html? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/system-calls-cairo1/$ https://book.cairo-lang.org/appendix-08-system-calls.html? [R=301,L]
RewriteRule ^tools/compatibility/$ /resources/compatibility? [R=301,L]
RewriteRule ^guides/cairo-101/$ /guides/cairo-101/overview? [R=301,L]
RewriteRule ^guides/cairo-101/overview/$ /guides/starknet-by-example/overview? [R=301,L]
RewriteRule ^guides/starknet-by-example/$ /guides/starknet-by-example/overview? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/transaction-life-cycle/$ /architecture-and-concepts/transactions? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/transactions/$ /resources/transactions-reference? [R=301,L]
RewriteRule ^architecture-and-concepts/accounts/account-functions/$ /architecture-and-concepts/accounts? [R=301,L]
RewriteRule ^architecture-and-concepts/accounts/approach/$ /architecture-and-concepts/accounts? [R=301,L]
RewriteRule ^architecture-and-concepts/accounts/deploying-new-accounts/$ /architecture-and-concepts/accounts? [R=301,L]
RewriteRule ^architecture-and-concepts/accounts/introduction/$ /architecture-and-concepts/accounts? [R=301,L]
RewriteRule ^architecture-and-concepts/accounts/simplified-transaction-flow/$ /architecture-and-concepts/accounts? [R=301,L]
RewriteRule ^quick-start/devnet/$ /guides/quickstart/devent? [R=301,L]
RewriteRule ^quick-start/environment-setup/$ /guides/quickstart/environment-setup? [R=301,L]
RewriteRule ^quick-start/hellostarknet/$ /guides/quickstart/hellostarknet? [R=301,L]
RewriteRule ^quick-start/next-steps/$ /guides/quickstart/next-steps? [R=301,L]
RewriteRule ^quick-start/overview/$ /guides/quickstart/overview? [R=301,L]
RewriteRule ^quick-start/sepolia/$ /guides/quickstart/sepolia? [R=301,L]
RewriteRule ^quick-start/troubleshooting/$ /guides/quickstart/troubleshooting? [R=301,L]
RewriteRule ^starkgate/architecture/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/automated-actions-with-bridging/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/cancelling-a-deposit/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/depositing/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/overview/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/troubleshooting/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/withdrawing/$ /architecture-and-concepts/starkgate? [R=301,L]
RewriteRule ^starkgate/function-reference/$ /resources/starkgate-reference? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/os$ /architecture-and-concepts/os? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/block-structure$ /architecture-and-concepts/blocks? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/data-availabilty$ /architecture-and-concepts/data-availabilty? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/fee-mechanism$ /architecture-and-concepts/fees? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/messaging-mechanism$ /architecture-and-concepts/messaging? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/starknet-state$ /architecture-and-concepts/state? [R=301,L]
RewriteRule ^architecture-and-concepts/network-architecture/messaging-reference$ /resources/messaging-reference? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/starknet-events/$ https://book.cairo-lang.org/ch101-03-contract-events.html [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/execution-info/$ /? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/compiled-class-hash/$ /? [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/contract-address/$ https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/class-hash/$ https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/contract-classes/$ https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/cairo-and-sierra/$ https://book.cairo-lang.org/appendix-09-sierra.html [R=301,L]
RewriteRule ^architecture-and-concepts/smart-contracts/serialization-of-cairo-types/$ https://book.cairo-lang.org/ch102-04-serialization-of-cairo-types.html [R=301,L]
RewriteRule ^architecture-and-concepts/(.*)$ /architecture/$1 [R=301,L]
RewriteRule ^architecture/economics-of-starknet/$ /architecture/strk? [R=301,L]
RewriteRule ^archive/starkgate/architecture$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/automated-actions-with-bridging$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/cancelling-a-deposit$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/depositing$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/overview$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/troubleshooting$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/withdrawing$ /architecture/starkgate? [R=301,L]
RewriteRule ^archive/starkgate/function-reference$ /resources/starkgate-reference? [R=301,L]
RewriteRule ^architecture/protocol-overview/$ /architecture/overview? [R=301,L]
RewriteRule ^archive/architecture/overview/$ /architecture/overview? [R=301,L]
RewriteRule ^resources/glossary/$ /archive/glossary? [R=301,L]
RewriteRule ^archive/architecture/solidity-verifier/$ /architecture/sharp? [R=301,L]
RewriteRule ^guides/starknet-by-example/(.*)$ /archive/starknet-by-example/$1? [R=301,L]
RewriteRule ^guides/cairo-101/(.*)$ /archive/cairo-101/$1? [R=301,L]
RewriteRule ^guides/staking-on-starknet/(.*)$ /guides/becoming-a-validator/$1 [R=301,L]
RewriteRule ^tools/(?!overview/?$)(.*)$ /archive/tools/$1 [R=301,L]
RewriteRule ^ecosystem/(?!overview/?$)(.*)$ /archive/ecosystem/$1 [R=301,L]



================================================
FILE: CI/Jenkinsfile
================================================
pipeline {
    agent { label "gcp-hodor-slave-generic"}
    options {
       // Add timestamps to output.
       timestamps()
       timeout(time: 10, unit: 'MINUTES')
    }
    environment {
        repoOwner = "starknet-io"
        repoName = "starknet-docs"
        prId = "${env.CHANGE_ID}"
        prPrefix = "pr"
        comment = "Your preview build is ready! ✨ Check the following link in 1-2 minutes: https://${repoOwner}.github.io/${repoName}/${prPrefix}-${prId}/ ."
        commitMessage = "Adding or updating preview build for PR: ${prId}"
        githubCredentials = credentials('gh-starknet-docs-pat')
    }
    stages {
        stage('Typos Tests') {
            agent {
                docker {
                    image 'rust:latest'
                    reuseNode true
                    args '--user root'
                }
            }
            steps {
                script {
                    sh label:"Install typos-cli", script:
                    """
                        cargo install typos-cli
                    """
                    sh label:"Run typos test", script:
                    '''
                        set +e

                        res=\$(typos)

                        if [ \$? != 0 ]
                        then
                            apt update
                            apt install -y python3-requests
                            python3 CI/scripts/comment_pr.py -a "$githubCredentials_PSW" -o "$repoOwner" -r "$repoName" -p "$prId" -c "Oops, your pull request failed to pass the Typo tests stage :( . see the result: \n\$res\n\nPlease fix the typo, commit and push!"
                            exit 1
                        fi
                    '''
                }
            }            
        }
        stage('Build') {
            agent {
                docker {
                    image 'node:16.20.2'
                    reuseNode true
                }
            }
            environment {
                ANTORA_CACHE_DIR="${WORKSPACE}/.cache"
            }
            steps {
                script {
                    sh label:"Install node modules", script:
                    """
                        yarn
                    """
                    sh label:"Generate site", script:
                    """
                        yarn generate
                    """
                    sh label:"Copy artifacts", script:
                    """
                        mkdir ${prPrefix}-${prId}
                        cp -r ./public_html/* ${prPrefix}-${prId}
                    """
                    stash includes: "${prPrefix}-${prId}/**/*", name: "artifact"
                }
            }
        }
        stage('Publish') {
            steps {
                script {
                    sh label:"Git clone", script:
                    '''
                        git clone https://$githubCredentials_PSW@github.com/starknet-io/starknet-docs.git
                    '''
                    sh label:"Git config", script:
                    """
                        git config --global user.name "Starknet Bot"
                        git config --global user.email "starknet-bot@noreply.com"
                    """
                    dir('starknet-docs') {
                        sh label:"Checkout gh-pages", script:
                        """
                            git checkout gh-pages
                        """
                        sh label:"Remove PR folder if exist", script:
                        """
                            if [ -d ${prPrefix}-${prId} ]
                            then
                                rm -rf ${prPrefix}-${prId}
                            fi
                        """
                        unstash 'artifact'
                        def result = sh (
                            label:"Push to branch gh-pages",
                            returnStatus: true,
                            script: 
                            '''
                                git add ${prPrefix}-${prId}
                                if ! git diff-index --quiet HEAD --; then
                                    echo "Changes detected. Committing and pushing changes."
                                    echo "Commit message: $commitMessage"
                                    git commit -m "$commitMessage"
                                    echo "Commit successful. Pushing changes."
                                    git pull
                                    git push
                                    exit 0
                                else
                                    echo "No changes found."
                                    exit 10
                                fi
                            '''
                        )
                        if (result == 10) {
                            echo 'Pipeline succeeded because there were no changes to push. Marking pipeline as SUCCESS.'
                            currentBuild.result = 'SUCCESS'
                            return
                        } else if (result != 0) {
                            echo 'Push to branch gh-pages step failed. Marking pipeline as FAILURE.'
                            currentBuild.result = 'FAILURE'
                            return
                        }
                        sh label:"Checkout ${env.CHANGE_TARGET}", script:
                        """
                            git checkout "${env.CHANGE_TARGET}"
                        """
                        sh label:"Comment preview link on contributor pull request", script:
                        '''
                            echo "Commenting preview link on PR: #$prId"
                            python3 CI/scripts/comment_pr.py -a "$githubCredentials_PSW" -o "$repoOwner" -r "$repoName" -p "$prId" -c "$comment"
                        '''
                    }
                }
            }
        }
    }
    post {
        cleanup {
            deleteDir()
        }
    }
}



================================================
FILE: CI/scripts/comment_pr.py
================================================
import requests
import argparse


def comment_pr(api_url, auth_token, owner, repo, pr_id, comment):
    url = f"{api_url}/repos/{owner}/{repo}/issues/{pr_id}/comments"

    headers = {
        'Authorization': f'Bearer {auth_token}',
        'Content-Type': 'application/json',
        'Accept': 'application/vnd.github.v3+json',
        'X-GitHub-Api-Version': '2022-11-28'
    }

    payload = {
        "body": comment
    }

    try:
        response = requests.post(url=url, headers=headers, json=payload)
        if response.status_code in (200, 201):
            print('Comment posted successfully!')
            print('Response:', response.json())
        else:
            print('Request failed with status code:', response.status_code)
    except Exception as e:
        print(e)


def main():
    parser = argparse.ArgumentParser(description="Create a comment on Github pull request.")
    parser.add_argument("-u", "--api_url", required=False, default="https://api.github.com", help="Github api url.")
    parser.add_argument("-a", "--auth_token", required=True, help="The Github auth token. Used to authenticate with Github.")
    parser.add_argument("-o", "--owner", required=True, help="The repo owner")
    parser.add_argument("-r", "--repo", required=True, help="The name of the repo")
    parser.add_argument("-p", "--pr", required=True, help="The pull request id/number")
    parser.add_argument("-c", "--comment", required=True, help="The message to comment")
    args = parser.parse_args()

    comment_pr(args.api_url, args.auth_token, args.owner, args.repo, args.pr, args.comment)

    exit(0)


if __name__ == "__main__":
    main()



================================================
FILE: js/algolia-index.js
================================================
const algoliasearch = require("algoliasearch");
const fs = require("fs");
const path = require("path");
const simpleGit = require("simple-git");
const Asciidoctor = require("asciidoctor");
const asciidoctor = Asciidoctor();
const { convert } = require("html-to-text");
const git = simpleGit(__dirname);

function resolvePath(...args) {
  return path.resolve(__dirname, ...args);
}

if (process.argv.length < 5) {
  throw new Error("Failed to find proper settings for Algolia indexing");
}
const algoliaAppId = process.argv[2];
const algoliaApiKey = process.argv[3];
const algoliaIndexNamePrefix = process.argv[4];

if (!algoliaAppId || !algoliaApiKey || !algoliaIndexNamePrefix) {
  throw new Error("Please setup Algolia settings in GitHub Action Secrets");
}

const initBranch = async () => {
  const status = await git.status();
  let currentBranch = status.tracking;
  currentBranch = currentBranch.split("/")[1];
  console.log(`Reindexing articles on branch "${currentBranch}" ...`);
  await clearOldIndex(currentBranch);
  startIndexing(currentBranch);
};

const clearOldIndex = async (currentBranch) => {
  const client = algoliasearch(algoliaAppId, algoliaApiKey);
  const algoliaIndex = client.initIndex(
    `${algoliaIndexNamePrefix}-${currentBranch}`
  );

  try {
    console.log(
      `Deleting all old records from index: ${algoliaIndex.indexName}`
    );
    await algoliaIndex.clearObjects();
    console.log("Old index cleared successfully.");
  } catch (error) {
    console.error("Error clearing old index:", error);
  }
};

const startIndexing = (currentBranch) => {
  const client = algoliasearch(algoliaAppId, algoliaApiKey);
  const algoliaIndex = client.initIndex(
    `${algoliaIndexNamePrefix}-${currentBranch}`
  );
  const commonPath = resolvePath("../", "components");

  fs.readdir(commonPath, "utf8", (err, data) => {
    if (err) {
      console.error(err, "err");
      return;
    }
    data.forEach((item) => {
      const nextPath = path.join(commonPath, item, "modules");
      fs.readdir(nextPath, "utf8", (errNext, dataNext) => {
        if (errNext) {
          console.error(errNext, "err_next");
          return;
        }
        dataNext.forEach((listItem) => {
          const pagePathFold = path.join(nextPath, listItem, "pages");
          fs.readdir(pagePathFold, "utf8", (pageErr, pageData) => {
            if (pageErr) {
              console.error(pageErr, "pageErr");
              return;
            }
            pageData.forEach((target) => {
              const targetPath = path.join(pagePathFold, target);
              const stat = fs.lstatSync(targetPath);
              if (stat.isDirectory()) {
                fs.readdir(targetPath, "utf-8", (fileErr, fileData) => {
                  if (fileErr) {
                    console.log(fileErr, "fileErr");
                    return;
                  }
                  fileData.forEach((targetFile) => {
                    const targetFilePath = path.join(targetPath, targetFile);
                    beforeUpload(targetFilePath, targetFile, algoliaIndex);
                  });
                });
              }
              beforeUpload(targetPath, target, algoliaIndex);
            });
          });
        });
      });
    });
  });
};

function beforeUpload(targetPath, target, algoliaIndex) {
  const stat = fs.lstatSync(targetPath);
  if (stat.isFile() && path.extname(target) === ".adoc") {
    fs.readFile(targetPath, "utf-8", (err, data) => {
      if (err) {
        console.error(err, "beforeUpload");
        return;
      }
      const titleFromAscii =
        data
          .split("\n")
          .find((str) => str.slice(0, 2) === "= ")
          ?.split("=")[1] ?? "";
      const titleFromMK =
        data
          .split("\n")
          .find((str) => str.slice(0, 2) === "# ")
          ?.split("#")[1] ?? "";
      const title = (titleFromAscii || titleFromMK).trim();

      const html = asciidoctor.convertFile(targetPath, {
        to_file: false,
        standalone: true,
      });
      const text = convert(html, { wordwrap: 130 });
      const recode = {
        objectID: targetPath.substring(targetPath.indexOf("modules") + 7),
        title: title,
        content: text,
      };
      uploadFile(recode, targetPath, algoliaIndex);
    });
  }
}

function uploadFile(file, targetPath, algoliaIndex) {
  const url = targetPath
    .split("modules")[1]
    .replace("/pages", "")
    .replace(".adoc", "")
    .replace("ROOT/", "")
    .replace("index", "");
  const record = {
    url: "https://docs.starknet.io" + url,
    ...file,
  };
  algoliaIndex.saveObject(record).wait();
  console.log("Done indexing ===>", url);
  console.log("Saved record title ===>", record.title);
  console.log("Saved record url ===>", record.url);
}

initBranch();



================================================
FILE: modules/architecture/nav.adoc
================================================
* Architecture
    ** xref:overview.adoc[Overview]
    ** xref:accounts.adoc[]
    ** xref:blocks.adoc[]
    ** xref:cryptography.adoc[]
    ** xref:data-availability.adoc[]
    ** xref:fees.adoc[]
    ** xref:messaging.adoc[]
    ** xref:sharp.adoc[]
    ** xref:os.adoc[]
    ** xref:staking.adoc[]
    ** xref:starkgate.adoc[]
    ** xref:state.adoc[]
    ** xref:strk.adoc[]
    ** xref:transactions.adoc[]



================================================
FILE: modules/architecture/pages/accounts.adoc
================================================
= Accounts

== Overview

Accounts represent users onchain, and enable them to interact with the blockchain. xref:ethereums_account_structure[Unlike Ethereum], Starknet facilitates account abstraction natively, via its unique account xref:starknets_account_structure[structure] and xref:account_nonces[nonce management]. Accounts can be xref:deploying_a_new_account[easily deployed on Starknet], both with or without having a preexisting account.

== Ethereum's account structure

Within Ethereum individual user accounts are known as Externally Owned Accounts (EOAs). EOAs differ from smart contracts in that EOAs are not controlled by code, but rather by a pair of private and public keys. The account's address is derived from those keys, and only by possessing the private key can you initiate transactions from an account. While simple, because the signature scheme is fixed, EOAs have some drawbacks, including the following:

* Control over the private key gives complete control over
the account, so you must keep your seed phrase secure yet accessible.
* Wallet functionality has limited flexibility 

https://eips.ethereum.org/EIPS/eip-4337[ERC-4337^] is a design proposal for Ethereum that outlines __account abstraction_, whereby all accounts are managed via a dedicated smart contract on the Ethereum network, as a way to increase flexibility and usability. Using account abstraction you can program how your account functions, including:

* Determine what it means for a signature to be valid, or what contracts your account is allowed to interact with, also known as _signature abstraction_

* Pay transaction fees in different tokens, also known as _fee abstraction_

* Design your own replay protection mechanism and allow sending multiple uncoupled transactions in parallel, also known as _nonce abstraction_
+
[NOTE]
====
Without account abstractions, EOAs cannot send two transactions in parallel, but rather must wait for confirmation of the first before sending the second, as otherwise the second transaction can be rejected due to an invalid nonce. With account abstraction, sequential nonces is not required.
====

Two prominent examples of how account abstraction might be used to program account functionality include:

* *Social recovery:* retrieving your wallet if in case its lost via a selected social network, vastly improving the typical experience of wallet recovery

* *Operating your account via facial recognition:* Using your phone's native hardware to sign transactions, making it practically impossible to take control of another user's account, even if your phone is stolen

== Starknet's account structure

Starknet's account structure is inspired by Ethereum's EIP-4337 where 
smart contract accounts with arbitrary verification logic are used instead of EOAs.
// === Account functions

A valid account contract in Starknet is simply a contract that includes the following functions:

[cols="1,3a"]
|===
| Function name | When required

| `+__validate__+` | Always required
| `+__execute__+` | Always required. The signatures of `+__validate__+` and `+__execute__+` must be identical.

[WARNING]
====
Two critical validations must happen in `+__execute__+`, and their absence can lead to draining of the account's funds:

(1) `assert!(get_caller_address().is_zero())`

This asserts that the account's `+__execute__+` is not called from another contract, thus skipping validations (in later versions we may disallow calling `+__execute__+` from another contract at the protocol level)

(2) `assert!(get_tx_info().unbox().version.into() >= 1_u32)`

This asserts that the transaction's version is at least 1, preventing the account from accepting `INVOKE` v0 transactions. It is critical to explicitly disallow the deprecated v0 transaction type, as v0 transactions assume that the signature verification happens in `+__execute__+`, and are thus skipping `+__validate__+` entirely.
====
| `+__validate_declare__+` | Required for the account to be able to send a `DECLARE` transaction. This function must receive exactly one argument, which is the class hash of the declared class.
| `+__validate_deploy__+` a| Required to allow deploying an instance of the account contract with a `DEPLOY_ACCOUNT` transaction. The arguments of `+__validate_deploy__+` must be the class hash of the account to be deployed and the salt used for computing the account's contract address, followed by the constructor arguments.

[NOTE]
====
You can only use the `+__validate_deploy__+` function in an account contract to validate the `DEPLOY_ACCOUNT` transaction for that same contract.
That is, this function runs at most once throughout the lifecycle of the account.
====
| `constructor` | All contracts have a `constructor` function. It can be explicitly defined in the contract, or if not explicitly defined, the sequencer uses a default `constructor` function, which is empty.
|===

=== Flow

When the sequencer receives a transaction, it calls the corresponding function with the appropriate input from the transaction's data, as follows:

* For a `DECLARE` transaction, the sequencer validates the transaction by calling the `+__validate_declare__+` function.

* For an `INVOKE` transaction, the sequencer calls the `+__validate__+` function with the transaction's calldata as input, after being deserialized to the arguments in the `+__validate__+` function's signature. After successfully completing validation, the sequencer calls the `+__execute__+` function with the same arguments.

* For a `DEPLOY_ACCOUNT` transaction, the sequencer calls the `constructor` function with the transaction's `constructor_calldata` as input, after being deserialized to the arguments in the constructor signature. After the successful execution of the constructor, the sequencer validates the transaction by calling the `+__validate_deploy__+` function.

[IMPORTANT]
====
For an `INVOKE` and `DEPLOY_ACCOUNT` transactions, it is up to the sender to make sure that the calldata is serializied correctly according to either the `+__validate__+` or `constructor` function's signature.
====

[NOTE]
====
Separating the validation and execution stages guarantees payment to sequencers for work completed and protects them from DoS attacks.
====

[TIP]
====
For more information on transaction types and lifecycle, see xref:architecture:transactions.adoc[].

For more information on the each transaction's fields, see xref:resources:transactions-reference.adoc[].
====

=== Limitations

The logic of the `+__validate__+`, `+__validate_deploy__+`, `+__validate_declare__+`, and `constructor` functions can be mostly arbitrary, except for the following limitations:

[NOTE]
====
For the `constructor` function, limitations apply only when run in a `DEPLOY_ACCOUNT` transaction (in particular, *not* when an account is deployed from an existing class via the `deploy` syscall)
====

* You cannot use more than 1,000,000 Cairo steps
* You cannot use more than 100,000,000 gas
* You cannot call the following syscalls:
** `get_class_hash_at`
** `get_sequencer_address` (this syscall is only supported for Cairo 0 contracts)
+
[IMPORTANT]
====
Starting from Starknet version 0.14.0, calling the `deploy` syscall from the `+__validate__+`, `+__validate_deploy__+`, `+__validate_declare__+`, and `constructor` functions will also not be possible.
====
* You cannot call functions in external contracts
+
[NOTE]
====
This restriction enforces a single storage update being able to invalidate only transactions from a single account. However, be aware that an account can always invalidate its own past transactions by e.g. changing its public key.

This limitation implies that the fees you need to pay to invalidate transactions in the mempool are directly proportional to the number of unique accounts whose transactions you want to invalidate.
====
* When calling the `get_execution_info` syscall:
** `sequencer_address` is set to zero
** `block_timestamp` returns the time (in UTC), rounded to the most recent hour
** `block_number` returns the block number, rounded down to the nearest multiple of 100


These limitations are designed to prevent the following DoS attacks on the sequencer:

* An attacker could cause the sequencer to perform a large amount of work before a transaction fails validation. Two examples of such attacks are:
** Spamming `INVOKE` transactions whose `+__validate__+` requires many steps, but eventually fails
** Spamming `DEPLOY_ACCOUNT` transactions that are invalid as a result of the constructor or `+__validate_deploy__+` failing.
* The above attacks are solved by making sure that the validation step is not resource-intensive, e.g. by keeping the maximal number of steps low. However, even if the validation is simple, the following "mempool pollution" attack could still be possible:
. An attacker fills the mempool with transactions that are valid at the time they are sent.
. The sequencer is ready to execute them, thinking that by the time it includes them in a block, they will still be valid.
. Shortly after the transactions are sent, the attacker sends one transaction that somehow invalidates all the previous ones and makes sure it's included in a block, e.g. by offering higher fees for this one transaction.
An example of such an attack is having the implementation of `+__validate__+` checks that the value of a storage slot is `1`, and the attacker's transaction later sets it to `0`. Restricting validation functions from calling external contracts prevents this attack.

=== Failures

When the `+__validate__+`, `+__validate_deploy__+`, or `+__validate_declare__+` functions fail, the account in question does not pay any fee, and the transaction's status is `REJECTED`.

When the `+__execute__+` function fails, the transaction's status is `REVERTED`. Similar to Ethereum, a reverted transaction is included in a block, and the sequencer is eligible to charge a fee for the work done up to the point of failure.

[TIP]
====
To learn more about transaction statuses, see xref:transactions.adoc#transaction_statuses[Transactions].
====

=== SNIP-6

While not mandatory at the protocol level, you can use a richer standard interface for accounts, defined in https://github.com/starknet-io/SNIPs/blob/main/SNIPS/snip-6.md[Starknet Improvement Proposal 6 (SNIP-6)^]. SNIP-6 was developed by community members at https://www.openzeppelin.com/[OpenZeppelin^], in close collaboration with wallet teams and other core Starknet developers.

=== Example

Thanks to account abstraction, the logic of `+__execute__+` and the different validation functions is up to the party implementing the account. To review a concrete implementation, you can check out OpenZeppelin's https://github.com/OpenZeppelin/cairo-contracts/blob/v0.14.0/src/account/account.cairo#L72[account component^], which also adheres to xref:snip-6[SNIP6].

== Account nonces

Similar to Ethereum, every contract in Starknet, including account contracts, has a nonce. The nonce of a transaction sent from an account must match the nonce of that account, which changes after the transaction is executed — even if it was reverted. Nonces serves two important roles:

* They guarantee transaction hash uniqueness, which is important for a good user experience
* They provide replay protection to the account, by binding the signature to a particular nonce and preventing a malicious party from replaying the transaction

Also similarly to Ethereum, Starknet currently determines the nonce structure at the protocol level to be sequential (i.e., the nonce of a transaction sent from an account is incremented by one after the transaction is executed). In the future, Starknet will consider a more flexible design, extending account abstraction to nonce abstraction.

However, unlike Ethereum, only the nonce of account contracts — that is, those adhering to xref:starknets_account_structure[Starknet's account structure] — can be non-zero in Starknet. In contrast, in Ethereum, regular smart contracts can also increment their nonce by deploying smart contracts (i.e., executing the `CREATE` and `CREATE2` opcodes).

== Deploying a new account

New accounts can be deployed in the following ways:

* Sending a `DEPLOY_ACCOUNT` transaction, which does not require a preexisting account.
* Using the https://docs.openzeppelin.com/contracts-cairo/0.12.0/udc[Universal Deployer Contract (UDC)^], which requires an existing account to send the `INVOKE` transaction

Upon receiving one of these transactions, the sequencer performs the following steps:

. Runs the respective validation function in the contract, as follows:
** When deploying with the `DEPLOY_ACCOUNT` transaction type, the sequencer executes the `+__validate_deploy__+` function in the deployed contract.
** When deploying using the UDC, the sequencer executes the `+__validate__+` function in the contract of the sender's address.
. Executes the constructor with the given arguments.
. Charges fees from the new account address.
+
[NOTE]
====
If you use a `DEPLOY_ACCOUNT` transaction, the fees are paid from the address of the deployed account. If you use the UDC, which requires an `INVOKE` transaction, the fees are paid from the sender's account. For information on the differences between V1 and V3 `INVOKE` transactions, see xref:transactions.adoc#transaction_types[`INVOKE` transaction] in _Transaction types_.
====
. Sets the account's nonce as follows:
** `1`, when deployed with a `DEPLOY_ACCOUNT` transaction
** `0`, when deployed with the UDC



================================================
FILE: modules/architecture/pages/blocks.adoc
================================================
[id="block_structure"]
= Blocks

== Overview

A Starknet block is a list of transactions and a block header that contains xref:block_header_fields[multiple fields], including the xref:block_hash[hash of the previous block] and a xref:state_diff_commitment[commitment to their state diff], as well as xref:transactions_events_and_receipts_commitments[commitments to the transactions, events, and receipts] it includes.

== Block header fields

[%autowidth]
|===
| Name | Type | Description

|`block_number` | `u64` | The number of this block (i.e., its height)

| `parent_block_hash` | `felt252` | The xref:#block_hash[hash] of the block's parent

| `global_state_root` | `felt252` | A xref:state.adoc#state_commitment[commitment] to the new state

|`sequencer_address` | `ContractAddress` | The Starknet address of the sequencer that created the block

| `block_timestamp` | `Timestamp` | The time at which the sequencer began building the block, in seconds since the Unix epoch

|`transaction_count` | `u32` | The number of transactions in the block

|`events_count` | `u32` | The number of events in the block.

|`state_diff_length`| `u32` | The total amount of storage diffs, nonce updates, deployed contracts, and declared classes

|`state_diff_commitment`| `felt252` | A xref:#state_diff_hash[commitment] to the state diff of the block

| `transactions_commitment` | `felt252` | A xref:#transactions_events_receipts_commitments[commitment] to the transactions included in the block

| `events_commitment` | `felt252` | A xref:#transactions_events_receipts_commitments[commitment] to the events included in the block

| `receipts_commitment`| `felt252` | A xref:#transactions_events_receipts_commitments[commitment] to the receipts of the transactions included in the block

| `l1_gas_price` | `(u128, u128)` | The price of L1 gas that was used while constructing the block, where the first value is the price in wei and the second is the price in fri (see xref:fees.adoc[] for more details)

| `l1_data_gas_price` | `(u128, u128)` | The price of L1 blob gas that was used while constructing the block, where the first value is the price in wei and the second is the price in fri (see xref:fees.adoc[] for more details)

| `l2_gas_price` | `(u128, u128)` | The price of L2 gas that was used while constructing the block, where the first value is the price in wei and the second is the price in fri (see xref:fees.adoc[] for more details)

| `l1_da_mode` | `String` | `CALLDATA` or `BLOB`, depending on how Starknet state diffs are sent to L1

| `protocol_version` | `String` | The version of the Starknet protocol used when creating the block

|===

== Block hash

A block hash is defined by:

[,,subs="quotes"]
----
h(
    "STARKNET_BLOCK_HASH1",
    block_number,
    global_state_root,
    sequencer_address,
    block_timestamp,
    transaction_count || event_count || state_diff_length || l1_da_mode,
    state_diff_commitment,
    transactions_commitment
    events_commitment,
    receipts_commitment,
    gas_prices_hash
    0,
    parent_block_hash
)
----

Where:

- `h` is the xref:../../cryptography.adoc#poseidon-hash[Poseidon hash function]
- `transaction_count || event_count || state_diff_length || l1_da_mode` is the concatenation of the 64-bit representations of `transaction_count`, `event_count`, and `state_diff_length` with 0 if `l1_da_mode` is `CALLDATA` and 1 if `l1_da_mode` is `BLOB`
- `gas_prices_hash` is defined by:
+
[,,subs="quotes"]
----
h(
    "STARKNET_GAS_PRICES0",
    l1_gas_price_wei,
    l1_gas_price_fri,
    l1_data_gas_price_wei,
    l1_data_gas_price_fri,
    l2_gas_price_wei,
    l2_gas_price_fri
)
----
+
where `h` is the xref:../../cryptography.adoc#poseidon-hash[Poseidon hash function] and `l1_gas_price_wei`, `l1_gas_price_fri`, `l1_data_gas_price_wei`, `l1_data_gas_price_fri`, `l2_gas_price_wei`, and `l2_gas_price_fri` are the wei and fri denominated prices for the three resource types.

[TIP]
====
For a reference implementation, see link:https://github.com/starkware-libs/sequencer/blob/bb361ec67396660d5468fd088171913e11482708/crates/starknet_api/src/block_hash/block_hash_calculator.rs#L68[ `block_hash_calculator.rs`] in the Starknet sequencer's GitHub repository
====

== State diff commitment

The state diff commitment is defined by:

[,,subs="quotes"]
----
h(
    "STARKNET_STATE_DIFF0",
    s + r,
    deployed_address~1~, deployed_class_hash~1~, ... , deployed_address~s~, deployed_class_hash~s~,
    replaced_contract_address~1~, new_class_hash~1~, ... , replaced_contract_address~r~, new_class_hash~r~,
    d,
    declared_class_hash~1~, declared_compiled_class_hash~1~, ... , declared_class_hash~d~, declared_compiled_class_hash~d~,
    1,
    0,
    n,
    c~1~, k~1,1~, v~1,1~, ... ,k~1,m^1^~, v~1,m^1^~, ... ,c~n~, k~n,1~, v~n,1~, ... ,k~n,m^n^~, v~n,m^n^~,
    k,
    account~1~, new_nonce~1~, ... ,account~k~, new_nonce~k~
)
----

Where:

- `h` is the  Poseidon hash function
- `1` and `0` are placeholders that may be used in the future
- `c~i~,k~i,1~, v~i,1~, ... , k~i,m^i^~,v~i,m^i^~` are `m^i^` updates `(k~i,1~, v~i,1~), ... ,(k~i,m^i^~, v~i,m^i^~)` to contract addresses `c~i~`

== Transactions, events, and receipts commitments
The commitment to transactions, the commitment to events and the commitment to receipts are all roots of height-64 binary Merkle Patricia tries where the leaf at index `i` corresponds to:

* For transactions: `h(transaction_hash, signature)` for the ``i``'th transaction included in the block, where `h` is the xref:../../cryptography.adoc#poseidon-hash[Poseidon hash function].
Note that the signature is itself a (possibly empty) array of field elements.
* For events: The xref:#event_hash[event hash] of the ``i``'th emitted event included in the block
* For receipts: The xref:#receipt_hash[receipt hash] of the ``i``'th transaction receipt included in the block

[discrete]
=== Event hash

The hash of an https://book.cairo-lang.org/ch101-03-contract-events.html[event^] emitted by a contract whose address is `emitter_address` and a transaction whose hash is `tx_hash` is defined by:

[,,subs="quotes"]
----
h(
    emitter_address,
    tx_hash,
    h(keys),
    h(data)
)
----

Where `h` is the xref:../../cryptography.adoc#poseidon-hash[Poseidon hash function].

[discrete]
=== Receipt hash

The hash of a xref:transactions.adoc#transaction_receipt[transaction receipt] is defined by:

[,,subs="quotes"]
----
h(
    transaction_hash,
    actual_fee,
    h(messages),
    sn_keccak(revert_reason),
    h(l2_gas_consumed, l1_gas_consumed, l1_data_gas_consumed)
)
----

Where:

- `h` is the xref:../../cryptography.adoc#poseidon-hash[Poseidon hash function]
- `h(messages)` for `messages = (from~1~, to~1~, payload~1~), ... , (from~n~, to~n~, payload~n~)` is defined by:
+
[,,subs="quotes"]
----
h(
    n,
    from~1~, to~1~, h(len(payload~1~) || payload~1~), ... , from~n~, to~n~, h(len(payload~n~) || payload~n~)
)
----



================================================
FILE: modules/architecture/pages/cryptography.adoc
================================================
:stem: latexmath
[id="cryptography"]
= Cryptography

== Overview

Starknet is built on advanced cryptographic primitives that enable scalable, trustless computation using STARK proofs. These include a custom xref:#the_stark_field[prime field] and xref:#the_stark_curve[elliptic curve] and multiple xref:#hash_functions[hash functions] optimized for zero-knowledge performance.

== The STARK field

The STARK field is the finite field stem:[$$\mathbb{F}_P$$], where:

stem:[$$P$$] = stem:[2^{251} + 17\cdot2^{192} + 1] = 3618502788666131213697322783095070105623107215331596699973092056135872020481

[NOTE]
====
The `felt252` type in Cairo refers to elements of the STARK field.
====

== The STARK curve

The STARK curve is an elliptic curve defined over the STARK field by:

[stem]
++++
y^2 \equiv x^3 + \alpha \cdot x + \beta \pmod{P}
++++

where:

* stem:[\alpha] = 1
* stem:[\beta] = 3141592653589793238462643383279502884197169399375105820974944592307816406665

The curve's order is 3618502788666131213697322783095070105526743751716087489154079457884512865583, and the generator point stem:[G] in the Elliptic Curve Digital Signature Algorithm (ECDSA) implementation that is used in Cairo with respect to it is defined by:

* stem:[G_x] = 874739451078007766457464989774322083649278607533249481151382481072868806602
* stem:[G_y] = 152666792071518830868575557812948353041420400780739481342941381225525861407

[NOTE]
====
The STARK curve is commonly used in smart contracts, but is not distinguished by the Starknet protocol.
====

== Hash functions

There are three hash functions used throughout Starknet's specifications that map inputs to elements in the xref:#stark-field[STARK field].

=== Starknet Keccak

Starknet's version of the Keccak hash function, commonly denoted by stem:[$\text{sn_keccak}$], is defined as the first 250 bits of Ethereum's https://github.com/ethereum/eth-hash[keccak256^].

=== Pedersen hash

Starknet's version of the Pedersen hash function is then defined by:

[stem]
++++
h(a,b) = \left[\text{shift_point} + a_{low} \cdot P_0 + a_{high} \cdot P1 + b_{low} \cdot P2  + b_{high} \cdot P3\right]_x
++++

where:

* stem:[a_{low}] and stem:[b_{low}] are the 248 low of stem:[a] and stem:[b], respectively
* stem:[a_{high}] and stem:[b_{high}] are the 4 high bits of stem:[a] and stem:[b], respectively
* The values of the constants stem:[\text{shift_point}, P_0, P_1, P_2, P_3] can be found in https://github.com/starkware-libs/cairo-lang/blob/master/src/starkware/crypto/signature/fast_pedersen_hash.py[fast_pedersen_hash.py^]
* stem:[[P\]_x] denotes the stem:[x] coordinate of point stem:[$P$]

==== Array hashing
Let stem:[$h$] denote the pedersen hash function, then given an array stem:[$a_1,...,a_n$] of stem:[$n$] field elements
we define stem:[$h(a_1,...,a_n)$] to be:
[stem]
++++
h(...h(h(0, a_1),a_2),...,a_n),n)
++++

=== Poseidon hash

[TIP]
====
Poseidon is a family of hash functions designed to be very efficient as algebraic circuits. As such, they can be very useful in ZK-proving systems such as STARKs.
====

Starknet's version of the Poseidon hash function is based on a three-element state Hades permutation and defined of up to 2 elements by:

[stem]
++++
\text{poseidon}(x) := \left[\text{hades_permutation}(x,0,1)\right]_0
++++

[stem]
++++
\text{poseidon}(x,y) := \left[\text{hades_permutation}(x,y,2)\right]_0
++++

Where latexmath:[[\cdot\]_j] denotes taking the stem:[j]'th coordinate of a tuple.

==== Array hashing
Let stem:[$\text{hades}:\mathbb{F}_P^3\rightarrow\mathbb{F}_P^3$] denote the Hades permutation with Starknet's parameters, then given an array stem:[$a_1,...,a_n$] of stem:[$n$] field elements
we define stem:[$\text{poseidon}(a_1,...,a_n)$] to be the first coordinate of stem:[$H(a_1,...,a_n;0,0,0)$], where:

[stem]
++++
H(a_1,...,a_n;s_1,s_2,s_3)=\begin{cases}
H\big(a_3,...,a_n;\text{hades}(s_1+a_1, s_2+a_2, s_3)\big), & \text{if  } n\ge 2 \\
\text{hades}(s_1+a_1,s_2+1,s_3), & \text{if  } n=1 \\
\text{hades}(s_1+1,s_2,s_3), & \text{if  } n=0 \\
\end{cases}
++++

[TIP]
====
For reference implementations of the above see link:https://github.com/starkware-libs/cairo-lang/blob/12ca9e91bbdc8a423c63280949c7e34382792067/src/starkware/cairo/common/poseidon_hash.py#L46[poseidon_hash.py^] and link:https://github.com/starkware-libs/cairo-lang/blob/12ca9e91bbdc8a423c63280949c7e34382792067/src/starkware/cairo/common/builtin_poseidon/poseidon.cairo#L28[poseidon.cairo^] in the cairo-lang GitHub repository.
====

==== Additional resources

* https://github.com/starkware-industries/poseidon/blob/main/poseidon3.txt[Parameters for defining the Poseidon permutation used in Starknet^]
* https://github.com/CryptoExperts/poseidon[Implementation in C and assembly by CryptoExperts^]



================================================
FILE: modules/architecture/pages/data-availability.adoc
================================================
[id="data_availability"]
= Data availability

== Overview

Starknet is a Validity Rollup, which means that after consolidating and proving a set of changes to Starknet's state, it updates the latest proven state on Ethereum. Alongside the proof, it sends the xref:#state_diff_format[formatted] difference between the previous and new states, also known as _state diff_, allowing anyone monitoring Ethereum to use this data and reconstruct Starknet's current state.

== State diff format

=== Pre-v0.11.0

Before Starknet version 0.11.0, state diffs contained information on every contract whose storage was updated, along with additional information on contract deployments. Those differences were sent as part of the calldata of the transaction that registered the proof on Ethereum, in a `uint256[]` array that included:

* The number of contracts that were deployed 
* The address and class hash of each deployed contract
* The number of contracts whose storage was updated
* For each contract whose storage was updated:
** Its address 
** A `uint256` value that encodes both the number of its storage updates and its updated nonce, defined as follows:
+
[stem]
++++
\underbrace{0\cdots0}_{\text{128 bits}} | \underbrace{\text{new nonce}}_{\text{64 bits}} |
{\underbrace{\text{# of storage updates}}_{\text{64 bits}}}_{\text{LSB}}
++++
+
** The key and new value for each storage update

This format is demonstrated by the following example:

[source,json]
----
[
  2, <1>
  2472939307328371039455977650994226407024607754063562993856224077254594995194, <2>
  1336043477925910602175429627555369551262229712266217887481529642650907574765, <3>
  1, <4>
  2019172390095051323869047481075102003731246132997057518965927979101413600827, <5>
  18446744073709551617, <6>
  5, <7>
  102, <8>
]
----

<1> The number of deployed contracts
<2> The address of the first, and only, contract whose state changed
<3> The class hash of the first, and only, contract whose state changed
<4> The number of contracts whose storage was updated
<5> The address of the first, and only, contract whose storage was updated
<6> The `uint256` value that encodes the number of storage updates and updated nonce of the first, and only, contract whose storage was updated, which equals stem:[$2^{64}+1 = 0^{128}|0^{63}1|0^{63}1$] and therefore:
* One storage cell was updated
* The updated nonce is `1`
<7> The key of the first, and only, storage update of the first, and only, contract whose storage was updated
<8> The new value of the first, and only, storage update of the first, and only, contract whose storage was updated

=== v0.11.0

In Starknet version 0.11.0, state diffs changed to contain information on every contract whose storage was updated and additional information on contract deployments. This information was still sent as part of the calldata of the transaction that registered the proof on Ethereum, in a `uint256[]` array that included:

* The number of contracts whose storage was updated 
* For contract whose storage was updated:
** Its contract address
** A single 32-byte word that includes its updated nonce and meta information about the storage updates, defined as follows:
+
[stem]
++++
\underbrace{0\cdots0}_{\text{127 bits}}|
\underbrace{\text{class information flag}}_{\text{1 bit}}|
\underbrace{\text{new nonce}}_{\text{64 bits}}|{
\underbrace{\text{# of storage updates}}_{\text{64 bits}}}_{\text{LSB}}
++++
+
where the class information flag's value is `1` if the contract was deployed or replaced and `0` otherwise (i.e., there were only storage updates). When set to `1`, the new class hash occupies the next entry in the array
** The key and new value for each storage update
* The number of classes that were declared
* The class hash and compiled class hash of each declared class

This format is demonstrated by the following example:

[source,json]
----
[
  1, <1>
  2019172390095051323869047481075102003731246132997057518965927979101413600827, <2>
  18446744073709551617, <3>
  100, <4>
  200, <5>
  1, <6>
  1351148242645005540004162531550805076995747746087542030095186557536641755046, <7>
  558404273560404778508455254030458021013656352466216690688595011803280448032 <8>
]
----
<1> The number of contracts whose storage was updated
<2> The address of the first, and only, contract whose storage changed
<3> The 32-byte word that encodes the updated nonce and meta information about the storage updates of the first, and only, contract whose storage was updated, which equals stem:[$2^{64}+1 = 0^{127}|0|0^{63}1|0^{63}1$] and therefore:
* One storage cell was update
* The new nonce is `1`
* The class information flag is `0`, which means that the contract was not deployed or replaced and therefore the next word shouldn't be treated as the class hash
<4> The key of the first, and only, storage update of the first, and only, contract whose storage was updated
<5> The new value of the first, and only, storage update of the first, and only, contract whose storage was updated 
These two elements, `100` and `200`, encode the storage update, where the value of key `100` is set to `200`.
<6> The number of classes that were declared
<7> The class hash of the first, and only, declared class
<8> The compiled class hash of the first, and only, declared class

=== v0.13.1

In Starknet version 0.13.1, sending state diffs to Ethereum changed from using calldata to using either calldata or blobs. Under normal conditions, using blobs is default method, but in extreme situations where blob prices significantly exceed those of calldata, the Starknet sequencer can switch to use calldata instead.

[TIP]
====
See https://community.starknet.io/t/data-availability-with-eip4844/[Data availability with EIP-4844^] on the Starknet Community Forum or review https://etherscan.io/tx/0x8a227491bc78424c2cac1b203c95cdd99ede5112d41f0e7eab26f3c8aa9c658d/[an example blob published on Ethereum by the Starknet sequencer^] for more details.
====

The format for state diffs remains the same as in version 0.11.0, but the data sent to Ethereum changed to a Fast Fourier Transform (FFT) of the original data. To recover Starknet's state diff based on blobs or calldata published onchain, an Inverse Fast Fourier Transform (IFFT) on the data must first be performed, afterwhich decoding can proceed as usual.

=== v0.13.3

In Starknet version 0.13.3, sending state diffs to Ethereum changed from sending raw state diffs to sending compressed state diffs. The employed compression scheme is a simple lookup table variant, where a list of 252-bit field elements is transformed into a (usually smaller) list of 252-bit field elements as follows:

. Unique field elements in the data are split into buckets of 15, 31, 62, 83, 125, and 252 bits (i.e. felts that require less than 15 bits go into the 15 bits bucket, felts that require 16 to 31 bits go into the 31 bits bucket, and so on).

. Each bucket is packed according to its number of bits (e.g., the 31 bits bucket allows the packing of 8 elements into a single felt).

. A list of pointers whose length is the length of the original data is constructed, where the ``i``'th pointer is the bucket of the ``i``'th element if the ``i``'th element is a first occurrence, or a special index that indicates a repetition otherwise.
+
[IMPORTANT]
====
The list of pointers can be packed to ~ 1/84 of the original list length since we only need 3 bits to indicate the bucket and we can fit 84 of those into a felt.
====

. A list of repeating value pointers is constructed, by adding `(bucket_index, index_in_bucket)` for every repetition in the original data.

To illustrate the above, consider the following example: Let indices 0,1, …, 5 correspond to buckets 252, 125, …, 15, and let 6 denote a special bucket of repetitions. For the data list `[2^250, 10, 100, 2^63, 2^63+1, 10, 100]`, we construct the following:

* Bucket 252: `[2^250]`
* Bucket 83: `[2^63, 2^63+1]`
* Bucket 15: `[10, 100]`
* Pointers: `[0, 5, 5, 3, 3, 6, 6]`
* Repeating value pointers: `[(5, 0), (5, 1)]` (We have two repetitions: the first for 10, which is the first element in bucket index 5, and the second for 100, which is the second element in the same bucket)

The final compressed list packs each bucket and each list individually and adds some necessary metadata. 

[NOTE]
====
This simple-to-write compression was chosen over the common Brotli or gzip compressions employed by other chains for similar purposes because the compression must be proven (i.e., either the compression or decompression must be implemented within the Starknet OS, and therefore its efficiency is crucial).

You can find a Python implementation of it in the https://github.com/starkware-libs/cairo-lang[cairo-lang repository^].
====

To better lends itself to the new compression scheme, as well as allow its construction to be based on the state diff alone, the uncompressed encoding of contract diff headers also changed as follows:

[stem]
++++
|
\underbrace{\text{new nonce (if changed)}}_{\text{64 bits}}
|
\underbrace{\text{# of storage updates}}_{\text{64 bits}}
|
\underbrace{\text{class information flag}}_{\text{1 bit}}
|
{\underbrace{\text{updates information flag}}_{\text{1 bit}}}_{\text{LSB}}
++++
where:

* The updates information flag is `0` if the number of updates is less than 256 (and therefore can fit in 8 bits), and `1` otherwise

* The semantics of class information flag is unchanged (i.e., it indicates whether or not the class was replaced)

* If the nonce of the contract is unchanged, the value of the new nonce is zero
+
[NOTE]
====
This definition can slightly deviate from the previous semantics, if an account contract was modified externally (e.g., via `execute_from_outside`). In this case, the contract's nonce is unchanged, yet it appears in the state update (since its storage was updated). Pre-v0.13.3, the current nonce of the account would have appeared although it is unchanged, while in v0.13.3 the value of new nonce is zero. This change helps with making the encoding derivable solely from the state diff itself, without referring to the global state of the chain.
====

=== v0.13.4

In Starknet v0.13.4, a second layer, termed _stateful compression_, was added to the compression of state diffs.

Stateful compression is based on the observation that most parts that were “incompressible” by the previous compression — now termed _stateless compression_ — are storage keys and contract addresses, which can be indexed based on their first occurrence in a state diff, thus encoding them with potentially much less than the full 32bytes.

To achieve this, a new system contract at address `0x2` was introduced, defined as follows:

* Storage slot `0x0` of the contract is the value of a global counter, initialized to `128` in the beginning of the first block of v0.13.4.

* Whenever a non-indexed storage key or contract address appears in a state diff, it is mapped to the current value of the counter, and the counter is increased.
+
[NOTE]
====
Storage keys that require at most 127 bits and addresses of system contracts (currently, `0x1` and `0x2`) are not mapped and continue to be referred to directly.
====

* The (uncompressed) state-diff includes the corresponding counter values from the value-to-index mapping rather than the original values.

As its name suggests, stateful compression introduces dependency between state diffs submitted to Ethereum. That is, state diffs of a given block cannot be decoded without knowing the state diffs of the previous blocks. This dependency is only relevant for post-v0.13.4 state diffs, while pre-v0.13.4 state diffs remain self-contained.

[IMPORTANT]
====
Starknet v0.13.4 introduces dependency between state diffs, making post-v0.13.4 state diffs non-decodable without knowledge of previous post-v0.13.4 state diffs.
====



================================================
FILE: modules/architecture/pages/fees.adoc
================================================
[id="gas-and-transaction-fees"]
= Fees

== Overview

Every transaction on Starknet requires a small fee to process. The components contributing to this fee include xref:#fee_components [L2 computation, L2 data, and L1 data], which are measured in xref:#fee_resources[L2 gas, L1 gas, and L1 data gas]. A transaction's fee can be xref:#estimating_fees[estimated] and xref:fee_limits[limited], and is ultimately xref:#charging_fees[charged] based on a predefined xref:#overall_fee[formula].


[NOTE]
====
This section describes fees that are paid on L2 starting in Starknet 0.13.0.

For information about messaging fees that are paid on L1, see xref:messaging.adoc#l1-l2-message-fees[L1→L2 message fees].
====

== Fee components

The following components contribute to a transaction's fee:

* xref:#l2_computation[]
* xref:#l2_data[] (calldata, events and code)
* xref:#l1_data[], which includes:
** The cost of posting the state diffs induced by the transaction to L1 (for more details, see xref:data-availability.adoc[])
** L2→L1 messages (which are eventually sent to the Starknet core contract as L1 calldata by the Starknet sequencer)

== Fee units

The three components contributing to a transaction's fee are measured by the following three units:

* _L2 gas_, measuring L2 resources, including computation and data
* _L1 data gas_, measuring the L1 data required to post the state diff induced by the transaction to L1
* _L1 gas_, measuring the L1 gas required for sending L2→L1 messages, as well as replacing:
** L1 data gas, in case the L2 block in which the transaction was included uses calldata instead of blobs for data availability (for more details, see xref:data-availability.adoc[])
** L2 gas, in the case the transaction did not specify L2 gas bounds

[NOTE]
====
There is a rather natural way to convert costs denominated in L1 gas to costs denominated in L2 gas and vice versa. One Cairo step costs 100 L2 gas, and we charge 0.0025 L1 gas per step 
when tracking VM resources (see xref:#l2_computation[] for more details), hence can decide that 1 L1 gas = 40,000 L2 gas.

This is only a temporary measure to use existing prices (denominated in L1 gas) when the transaction consumes L2 gas, as L1 gas and L2 gas are completely independent resources. Moreover, the step cost of 0.0025 L1 gas 
is mostly arbitrary at this point due to our use of dynamic layouts (see xref:#vm_resources[] for more information)
====

== Fee estimations

The fee for a transaction can be estimated by using the https://github.com/starkware-libs/starknet-specs/blob/v0.7.1/api/starknet_api_openrpc.json#L612[`starknet_estimateFee` endpoint^], and interfaces for fee estimations are also exposed by the various xref:tools:overview.adoc[Starknet SDKs].

[NOTE]
====
When submitting transactions via Starknet's JSON-RPC v0.7.1 or below, the only bounded resource is L1 gas, while the fee estimation contains both L1 gas and L1 data gas. 
In that case, we can use the estimation's `overall_fee` to decide on the L1 gas bounds.

You can find more details in the https://community.starknet.io/t/starknet-v0-13-1-pre-release-notes/113664#sdkswallets-how-to-use-the-new-fee-estimates-7[Starknet v0.13.1 prerelease notes^].
====

== Fee limits

Starting in Starknet v0.14.0, all transactions will have to specify STRK-denominated `max_amount` and `max_price_per_unit` for each of the three xref:fee_units[fee unit]. A necessary condition for a transaction to enter a block is that `max_price_per_unit` is greater than or equal to the xref:gas_prices[block's corresponding price] for each resource, but if included sequencers are then enforced by the xref:os.adoc[Starknet OS] (and as such, enforced by a proof) to charge no more than the max price specified by the transaction.

[NOTE]
====
`v3` transactions already provide these bounds (as part of the `resource_bounds` dictionary), while previous versions only provide a WEI-denominated overall `max_fee`.

Sequencers usually charges less than the max price specified in the transaction, as charges are in accordance with the xref:#overall_fee[formula for determining a transaction's fee].
====

== Fee charges

The fee for a transaction is charged atomically with the transaction execution on L2, by the Starknet OS injecting a transfer of STRK with an amount equal to the fee paid, the sender equal to the transaction submitter, and the sequencer as a receiver.

[NOTE]
====
Starknet does not currently implement burning of fees, and all fees charged are received by the sequencer.
====

== Fee formula

[IMPORTANT]
====
Starknet's fee formula is highly non-trivial.

To mitigate this, the first section details the formula for determining a transaction's overall fee, while subsequent ones dive into the different fee components and explain how this formula was derived.

Some parts may require reading more than once, but don't hesitate to https://github.com/starknet-io/starknet-docs/issues/new?assignees=landauraz&title=Feedback%20for%20%22The%20Starknet%20operating%20system%22[reach out^] if you feel further clarification is needed.
====

[NOTE]
====
While sequencer are xref:fee_limits[enforced not to overcharge fees], they are not yet enforced to charge fees charged according to Starknet's fee formula.
====

=== Overall fee

The following formula describes the overall fee of a transaction:

[stem]
++++
\begin{align}
\qquad & \text{l1_gas_price} \cdot\Bigg( \\
& \qquad \text{message_calldata_cost}\cdot 3t \; + \\
& \qquad \; (\text{message_calldata_cost} + \text{l1_log_data_cost})\cdot \sum\limits_{i=1}^t q_i \; + \\
& \qquad \; \left(\text{l1_storage_write_cost}+\text{log_message_to_l1_cost}\right)\cdot t \\
& \Bigg) + \; (\text{l2_gas_price} + \text{tip}) \cdot (\text{sierra_gas_consumed} + \max_k v_k w_k + \text{l2_payload_costs}) \\
& \quad + \; \begin{cases}\text{l1_data_gas_price}\cdot\text{felt_size_in_bytes}\cdot\big(\ell + 2(n-1) + 2(m-1) + 2D \big) & \text{if l1_da_mode is BLOB} \\ \\ \text{l1_gas_price} \cdot \Big( \\ \qquad \text{da_calldata_cost} \cdot \left(\ell + 2(n-1)+2(m-1) + 2D\right) \; - \\ \qquad \text{contract_update_discount}\cdot (n-1) \; - & \text{if l1_da_mode is CALLDATA} \\ \qquad \text{sender_balance_update_discount} \\ \Big)\end{cases}
\end{align}
++++

where:

* stem:[\text{l1_gas_price}] is the L1 gas price of the block that includes the transaction (see xref:gas_prices[] for more information)

* stem:[$\text{message_calldata_cost}$] is 1,124 gas

* stem:[$t$] is the number of L2->L1 messages sent by the transaction

* stem:[$\text{l1_log_data_cost}$] is 256 gas

* stem:[$t$] stem:[$q_1,...,q_t$] are the payload sizes of the L2->L1 messages sent by the transaction

* stem:[$\text{l1_storage_write_cost}$] is 20,000 gas (the cost of writing to a new storage slot on Ethereum)

* stem:[$\text{log_message_to_l1_cost}$] is 1,637 gas (see xref:#l2l1_messages[] for more information)

* stem:[\text{l2_gas_price}] is the L2 gas price of the block that includes the transaction (see xref:gas_prices[] for more information)

* stem:[\text{tip}] is the tip specified by the transaction

* stem:[$\text{sierra_gas_consumed}$] is the amount of xref:#sierra_gas[] charged for computation of the transaction 

* stem:[$v$] is a vector that represents resource usage of the transaction (Cairo steps or number of applications of each builtin), where each of its entries, stem:[$v_k$], corresponds to the usage of a different resource type (see xref:#vm_resources[] for more information)
+
[NOTE]
====
The fee formula of a transaction can track both raw VM resources (reflected by stem:[$v_k$]) and Sierra gas, depending on what classes it goes through (see xref:#l2_computation[] for more details).
====

* stem:[$w$] is the `CairoResourceFeeWeights` vector (see xref:#vm_resources[] for more information)

* stem:[$\text{l2_payload_costs}$] is the gas cost of the data sent by the transaction over Starknet, which includes calldata, code, and event emission (see xref:#l2_data[] for more information)

* stem:[\text{l1_da_mode}] is stem:[\text{CALLDATA}] or stem:[\text{BLOB}] depending on how the state diff of the block that includes the transaction is sent to L1 (see xref:data-availability.adoc[] for more information)

* stem:[\text{l1_data_gas_price}] is the L1 data gas price of the block that includes the transaction (see xref:gas_prices[] for more information)

* stem:[$\text{felt_size_in_bytes}$] is 32 (the number of bytes required to encode a single STARK field element)

* stem:[$\ell$] is the number of contracts whose class was changed by the transaction, which happens on contract deployment and when applying the `replace_class` syscall

* stem:[$n$] is the number of unique contracts updated by the transaction, which also includes changes to classes of existing contracts and contract deployments, even if the storage of the newly deployed contract is untouched (in other words, stem:[$n\ge\ell$])
+
[NOTE]
====
Notice that stem:[$n\ge 1$] always holds, because the fee token contract is always updated, which does not incur any fee.
====

* stem:[$m$] is the number of storage values updated by the transaction, not counting multiple updates for the same key
+
[NOTE]
====
Notice that stem:[$m\ge 1$] always holds, because the sequencer's balance is always updated, which does not incur any fee.
====

* stem:[$D$] is 1 if the transaction is of type `DECLARE` and 0 otherwise, as declare transactions need to post on L1 the new class hash and compiled class hash which are added to the state

* stem:[$\text{da_calldata_cost}$] is 551 gas, derived as follows: 
+
** 512 gas per 32-byte word for calldata
** ~100 gas for onchain hashing that happens for every word sent
** a 10% discount for not incurring additional costs for repeated updates to the same storage slot within a single block

* stem:[$\text{contract_update_discount}$] is 312 gas (See xref:#storage_updates[] for more information)

* stem:[\text{sender_balance_update_discount}] is stem:[$240$] gas (see xref:#storage_updates[] for more information)

=== Gas prices

Each Starknet block has three integers associated with it: `l1_gas_price`, `l2_gas_price`, and `l1_data_gas_price`.

`l1_gas_price` and `l1_data_price` are computed by taking the average of the last 60 L1 base gas or data gas prices sampled every 60 seconds by the sequencer, plus 1 Gwei. For `l1_data_gas_price`, this number is then multiplied by a scaling factor of 0.135 that approximate for the average rate compression achieved from posting the data to Ethereum.

`l2_gas_price` is currently a fixed amount denominated in WEI (the price in FRI is only dependent on the WEI to FRI ratio). Starknet version 0.14.0 will introduce a fee market for  `l2_gas` similar to Ethereum's https://github.com/ethereum/EIPs/blob/master/EIPS/eip-1559.md[EIP 1559^], computing `l2_gas_price` as follows:

[stem]
++++
\max\left\{(1 + \frac{\text{prev_L2_gas_use} - \text{TARGET}}{\text{TARGET}}*C)* \text{prev_L2_gas_price}, \text{MIN_PRICE}\right\}
++++

where:

** stem:[\text{prev_L2_gas_use}] is the total L2 gas used in the previous block
** stem:[\text{TARGET}] is 2 * 10^9^ (xref:resources:chain-info.adoc#current_limits[half of Starknet's block capacity])
** stem:[0 < C < 1] is still TBD 
** stem:[\text{prev_L2_gas_price}] is the previous block's `l2_gas_price`
** stem:[\text{MIN_PRICE}] is still TBD 


This assures that:

* If the total gas used in the previous block is equal to stem:[\text{TARGET}], then `l2_gas_price` won't change
* If the total gas used in the previous block is larger or smaller than stem:[\text{TARGET}], then `l2_gas_price` will respectively decrease or increase by at most stem:[C]
* When there is no congestion in the network, the `l2_gas_price` will be equal to stem:[\text{MIN_PRICE}]

=== L2 computation

Measuring the L2 computation component of a transaction differs depending on the contract class version of the caller:

* For Sierra ≥ 1.7.0, computation is measured in xref:#sierra_gas[]

* For CairoZero classes or Sierra ≤ 1.6.0, computation is measured in xref:#vm_resources[]

+
[NOTE]
====
Sierra gas is only tracked if the parent call was also tracking Sierra gas, which means that if the account contract is Sierra 1.6.0 or older, VM resources will be tracked *throughout the entire transaction*. This condition may be relaxed in the future.
====

==== Sierra gas

[TIP]
====
The following is a very rough description of Sierra's built-in gas accounting mechanism. For a comprehensive analysis, see https://github.com/starkware-libs/cairo/blob/main/docs/other/gas_blog_post.pdf[_Analysis of the gas accounting algorithm of Cairo 1.0_ by CryptoExperts^].
====

A Sierra program has a simple structure: types and function declaration, followed by a sequence of applications of _libfuncs_, Sierra's basic logical units (similar to opcodes, e.g. `u8_add` is a libfunc).

The Cairo compiler defines a libfunc costs table, which is measured in “Sierra gas” and has a 1-1 ratio with L2 gas (i.e., a libfunc which costs 500 Sierra gas adds 500 to a transaction's overall L2 gas)

[NOTE]
====
Despite the 1-1 ratio between Sierra gas and L2 gas, L2 gas accounts for “everything L2”, while Sierra gas strictly deals with computation, hence the distinction in terminology. 
====

The cost of each libfunc is determined by its expanded CASM generated via the Sierra→CASM compiler based on a 100-1 ratio with Cairo steps (i.e., if a libfunc's assembly includes 10 Cairo steps, it will cost 1000 Sierra gas), while the costs of the various builtins are defined as follows:

[%autowidth.stretch,options="header"]
|===
| Builtin | Sierra gas cost |
| Range check | 70 |
| Pedersen | 4,050 |
| Poseidon | 491 |
| Bitwise | 583 |
| ECDSA | 10,561 |
| EC_OP | 4,085 |
| Keccak | 136,189 |
| ADD_MOD | 230 |
| MUL_MOD | 604 |
|===

[TIP]
====
To review pricing for various syscalls, see the `versioned constants.json` files in the https://github.com/starkware-libs/sequencer/tree/main/crates/blockifier/resources[sequencer's resources directory^].
====

To handle gas usage, Sierra has special libfuncs for gas-handling, such as the `withdraw_gas` libfunc. For functions with neither branching nor recursion, the Cairo→Sierra compiler adds a single `withdraw_gas\(C)` call in the beginning of the function, where `C` is the sum over the costs of the libfuncs included in the function. For functions with branching, the compiler adds a call to `withdraw_gas\(C)` before the actual branching, where `C` is the maximal branch cost.

[NOTE]
====
In its latest version, the compiler also adds a call to `redeposit_gas\(C)` on the cheaper branches, where `C` is unused gas on that branch.
====

For functions with recursion (or other cases where costs can only be known in runtime), things get trickier.
The naive way to handle such cases would be to add a `withdraw_gas` instruction after every libfunc, but since `withdraw_gas` itself has some cost (decreasing a counter and handling the insufficient gas case) this would incur a large burden on the program. 
Instead, the compiler constructs the call graph induced by the program, and asserts that every cycle includes a `withdraw_gas(X)` instruction, where `X` should cover the cost of a single run through the cycle, greatly reducing the overhead compared to the naive mechanism.

==== VM resources

A Cairo program execution yields an execution trace, and when proving a Starknet block, we aggregate all the transactions appearing in that block to the execution trace up to some maximal length stem:[$L$], derived from the specs of the proving machine and the desired proof latency.

Tracking the execution trace length associated with each transaction is simple, as Cairo step requires the same constant number of trace cells. Therefore, in a world without builtins, the fee associated with the L2 computation component of a transaction stem:[$tx$] should be correlated with stem:[$\text{TraceCells}[tx\]/L$].

[NOTE]
====
The aforementioned observation is no longer true for Starknet's next-gent prover Stwo, which handles some opcodes more efficiently than others. However, we neglect this intricacy for the purposes of this discussion.
====

When we introduce builtins into the equation, we need to consider an a priori limit for each builtin in the proof. This set of limits is known as the proof's _layout_, which determines the ratio between steps and each builtin. 

[NOTE]
====
Today, Starknet's prover is able to dynamically choose a layout based on a given block resource's consumption, i.e. there is no longer an a priori fixed layout. 
However, pricing for old classes still behaves as if we are using a fixed layout.
====

For example, consider that the prover can process a trace with the following limits:

[%autowidth]
|===
| Up to 500M Cairo steps | Up to 20M Pedersen hashes | Up to 4M signature verifications | Up to 10M range checks

|===

which means that a proof is closed and sent to L1 when any of these slots is filled. Now, suppose that a transaction uses 10K Cairo steps and 500 Pedersen hashes. At most 20M/500 = 40K such transactions can fit into the hypothetical trace, therefore its gas price should correlate with 1/40K of the cost of submitting proof (notice that this estimate ignores the number of Cairo steps as it is not the limiting factor, since 500M/10K > 20M/500).

With this example in mind, it is possible to formulate the exact fee associated with L2 computation. For each transaction, 
the sequencer calculates a vector, `CairoResourceUsage`, that contains the following:

* The number of Cairo steps
* The number of applications of each Cairo builtin (e.g., 5 range checks and 2 Pedersen hashes)

and crosses this information with a `CairoResourceFeeWeights` vector, a predefined weights vector in accordance with the proof parameters, in which each resource type has an entry that specifies the relative gas cost of that component in the proof. The sequencer then charges only according to the limiting factor, making the final fee defined by:

[stem]
++++
\max_k[\text{CairoResourceUsage}_k \cdot \text{CairoResourceFeeWeights}_k]
++++

where stem:[$k$] enumerates the Cairo resource components. Going back to the above example, if the cost of submitting a proof with 20M Pedersen hashes is roughly 5M gas, then the weight of the Pedersen builtin is 5,000,000/20,000,0000 = 25 gas per application.

==== VM resources vs. Sierra gas

The difference in tracking Sierra gas vs. tracking VM resources can be summed up as follows:

- For VM resources builtin weights reflect the proof layout, while for Sierra gas they reflect trace cell consumption
- For VM resources only the maximal resource (e.g., most used builtin) is considered, while for Sierra gas the sum of all resources (i.e., all libfuncs) is considered

This means that when the tracking Sierra gas, step-heavy transactions will most likely be slightly more expensive, as builtins will be taken into account _in addition_ to Cairo steps. On the other hand, builtin-heavy transactions will become much cheaper — depending on the builtin that maximized the old fee and with the exception of the Pedersen builtin.

=== L1 data

==== Storage updates

Whenever a transaction updates some value in the storage of some contract, the following data is sent to L1:

* One 32-bye word if the transaction is a `DEPLOY` transaction (since we need to specify the deployed contract's class hash)
* Two 32-byte words per contract
* Two 32-byte words for every updated storage value

[NOTE]
====
Only the most recent value reaches L1, making the transaction's fee depend on the number of _unique_ storage updates. If the same storage cell is updated multiple times within the transaction, the fee remains that of a single update.

For information on the exact data and its construction, see xref:architecture:data-availability.adoc#v0.11.0_format[Data availability].
====

Therefore, the storage update fee for a transaction is defined as follows:

[stem]
++++
\text{data_gas_price}\cdot\text{felt_size_in_bytes}\cdot\bigg(\ell + 2(n-1) + 2(m-1) + 2D \bigg)
++++

[NOTE]
====
This formula only refer to the case of submitting data to L1 via blobs, for the calldata case, see xref:#overall_fee[]).
====

where:

* stem:[$\text{felt_size_in_bytes}$] is 32, which is the number of bytes required to encode a single STARK field element.
* stem:[$\ell$] is the number of contracts whose class was changed, which happens on contract deployment and when applying the `replace_class` syscall.
* stem:[$n$] is the number of unique contracts updated, which also includes changes to classes of existing contracts and contract deployments, even if the storage of the newly deployed contract is untouched. In other words, stem:[$n\ge\ell$]. Notice that stem:[$n\ge 1$] always holds, because the fee token contract is always updated, which does not incur any fee.
* stem:[$m$] is the number of values updated, not counting multiple updates for the same key. Notice that stem:[$m\ge 1$] always holds, because the sequencer's balance is always updated, which does not incur any fee.
* stem:[$D$] is 1 if the transaction is of type `DECLARE` and 0 otherwise. Declare transactions need to post on L1 the new class hash and compiled class hash which are added to the state.

[NOTE]
====
Improvements to the above pessimistic estimation might be gradually implemented in future versions of Starknet.

For example, if different transactions within the same block update the same storage cell, there is no need to charge for both transactions, because only the last value reaches L1. In the future, Starknet might include a refund mechanism for such cases.
====

==== L2->L1 messages

When a transaction that raises the `send_message_to_l1` syscall is included in a state update, the following data reaches L1:

* L2 sender address
* L1 destination address
* Payload size
* Payload (list of field elements)

Therefore, the gas cost associated with a single L2→L1 message is defined as follows:

[stem]
++++
\qquad \text{message_calldata_cost} \cdot \left(3+\text{payload_size}\right) \; + \text{l1_log_data_cost}\cdot\text{payload_size} \; + \text{log_message_to_l1_cost} \; + \text{l1_storage_write_cost} \qquad
++++

Where:

* stem:[$\text{message_calldata_cost}$] is 1,124 gas, which is the sum of the 512 gas for submitting the state update to the core contract and 612 gas for the submitting the state update the verifier contract (which incurs ~100 additional gas for hashing)

* stem:[$\text{l1_log_data_cost}$] is 256 gas, paid for every payload element during the emission of the `LogMessageToL1` event

* stem:[$\text{log_message_to_l1_cost}$] is 1,637 gas, which is the fixed cost involved in emitting a `LogMessageToL1` event with two topics and a two words data array, resulting in a total of stem:[$375+2\cdot 375+2\cdot 256$] gas (log opcode cost, topics cost, and data array cost)

* stem:[$\text{l1_storage_write_cost}$] is 20K gas per message, paid in order to store the message hash on the Starknet core contract and enable the target L1 contract to consume the message

=== L2 data

As of Starknet v0.13.1 onwards, L2 data is also taken into account during pricing, including:

* Calldata, including transaction calldata (in the case of `INVOKE` transactions or `L1_HANDLER`), constructor calldata (in the case of `DEPLOY_ACCOUNT` transactions), and signatures
* Events, including data and keys of emitted events
* ABI, including classes ABI in `DECLARE` transactions (only relevant for `DECLARE` transactions of version ≥ 2)
* Casm bytecode (for all available `DECLARE` transactions, where in version < 2 this refers to the compiled class)
* Sierra bytecode (relevant only for `DECLARE` transactions of version ≥ 2)

The L1 gas cost of each component in as follows:

[NOTE]
====
When a transaction's L2 cost is paid for by L2 gas, the following numbers are translated via the standard conversion rate of 1 L1 gas = 40K L2 gas.
====

[%autowidth.stretch,options="header"]
|===
| Resource | L2 Gas cost

| Event key | 10,240 gas/felt
| Event data | 5,120 gas/felt
| Calldata | 5,120 gas/felt
| CASM bytecode | 40,000 gas/felt
| Sierra bytecode | 40,000 gas/felt
| ABI | 1,280 gas/character
|===



================================================
FILE: modules/architecture/pages/messaging.adoc
================================================
= L1 ↔ L2 messaging

== Overview 
Starknet's ability to interact with L1 is crucial, and is used by bridges (e.g., for depositing your tokens in the L1 bridge contract, and automatically triggers the minting of the same token on L2), link:https://starkware.co/resource/defi-pooling/[DeFi pooling^] and https://www.starknet.io/en/ecosystem/dapps[more^]. Messaging — both xref:l2_l1_messages[from L1 to L2] and from xref:l1_l2_message_protocol[L2 to L1] — is the mechanism that enables this interaction.

[IMPORTANT]
====
Starknet's messaging mechanism is both _asynchronous_ and _asymmetric_.

* _Asynchronous_: Your contract code, whether Cairo or Solidity, cannot await the result of the message being sent on the other layer within your contract code's execution.
* _Asymmetric_: Sending a message from Ethereum to Starknet, L1->L2, is fully automated by the Starknet sequencer, so the message is automatically delivered to the target contract on L2. However, when sending a message from Starknet to Ethereum, L2->L1, the sequencer only sends the hash of the message. You must then consume the message manually using a transaction on L1.
====

.Additional resources

* https://book.cairo-lang.org/appendix-08-system-calls.html#send_message_to_l1[The `send_message_to_L1` syscall^]
* https://github.com/starkware-libs/cairo-lang/blob/54d7e92a703b3b5a1e07e9389608178129946efc/src/starkware/starknet/solidity/IStarknetMessaging.sol#L13[The Starknet Core contract's `sendMessageToL2` function^]
* https://book.cairo-lang.org/ch16-04-L1-L2-messaging.html[L1-L2 Messaging in the Cairo Book^]

== L2 -> L1 messages

=== L2 -> L1 message protocol

The L2 -> L1 message protocol consists of the following stages:

. During the execution of a transaction, a contract on Starknet sends a message from L2 to L1 by calling the `send_message_to_L1` syscall.
. The sequencer attaches the message parameters to the block that includes the syscall invocation. The message parameters include the address of the sender on L2, the address of the recipient contract on L1, and the message data.
+
For example:
+
[source,cairo]
----
let mut payload: Array<felt252> = ArrayTrait::new();
let to_address: EthAddress = 1_felt252.try_into().unwrap();
payload.append(1);
// potentially add more elements to payload (payload[1], payload[2],  etc.)

send_message_to_l1_syscall(to_address: to_address.into(), payload: payload.span());
----

. The prover proves the state update that includes this transaction.
. The sequencer updates the L1 state.
. The message is stored on L1 in the Starknet Core Contract and a counter on the Core Contract increases by one. +
. The `processMessage` function, which is part of the Starknet Core Contract, emits the `LogMessageToL1` event, which contains the message parameters.
. The message recipient on L1 can access and consume the message by calling the link:https://github.com/starkware-libs/cairo-lang/blob/4e233516f52477ad158bc81a86ec2760471c1b65/src/starkware/starknet/eth/StarknetMessaging.sol#L119[`consumeMessageFromL2`] function, which includes the message parameters within the transaction.
This function, which is part of the Starknet Core Contract, verifies the following:

* The hashes of the L2 sent message parameters, now stored on the Core Contract, and the L1 received message parameters, are the same.
* The entity calling the function is indeed the recipient on L1.
+
In such a case, the counter corresponding to the message hash in the Starknet Core Contract decreases by one. For more information, see the link:https://github.com/starkware-libs/cairo-lang/blob/4e233516f52477ad158bc81a86ec2760471c1b65/src/starkware/starknet/eth/StarknetMessaging.sol#L130C7-L130C7#[`consumeMessageFromL2`] function in `StarknetMessaging.sol`.

The protocol is summarized in the following illustration:

image::l2l1.png[L2->L1 message mechanism]

=== L2 -> L1 message structure

The structure of an L2 -> L1 message is defined under `MSG_TO_L1` in the https://github.com/starkware-libs/starknet-specs/blob/master/api/starknet_api_openrpc.json[Starknet API JSON RPC^] specification as follows:

[horizontal,labelwidth="30"]
`from_address` (`felt252`):: The address of the L2 contract sending the message.
`to_address` (`EthAddress`):: The target L1 address the message is sent to.
`payload` (`Array<felt252>`):: The payload of the message.

=== L2 -> L1 message hashing

The hash of an L2 -> L1 message is computed on L1 as follows:

[source,js]
----
keccak256(
    abi.encodePacked(
        FromAddress,
        uint256(ToAddress),
        Payload.length,
        Payload
    )
);
----

[NOTE]
====
Sending an L2 to L1 message always incurs a fixed cost of 20,000 L1 gas, because the hash of the message being sent must be written to L1 storage in the Starknet Core Contract.
====

== L1 -> L2 messages

=== L1 -> L2 message protocol

The L1 -> L2 message protocol consists of the following stages:

. An L1 contract induces a message to an L2 contract on Starknet by calling the link:https://github.com/starkware-libs/cairo-lang/blob/54d7e92a703b3b5a1e07e9389608178129946efc/src/starkware/starknet/solidity/IStarknetMessaging.sol#L13[`sendMessageToL2`] function on the Starknet Core Contract with the message parameters.
+
The Starknet Core Contract hashes the message parameters and updates the L1->L2 message mapping to indicate that a message with this hash was indeed sent. The L1 contract records the fee that the sender paid. For more information, see xref:#l1-l2-message-fees[L1 -> L2 message fees].
. The message is then decoded into a Starknet transaction that invokes a function annotated with the `l1_handler` decorator on the target contract. Transactions like this on L2 are called xref:#l1_handler_transaction[L1 handler transactions].
 .. The Starknet sequencer, upon receiving enough L1 confirmations for the transaction that sent the message, initiates the corresponding L2 transaction.
 .. The L2 transaction invokes the relevant `l1_handler` function.
. The L1 Handler transaction that was created in the previous step is added to a proof.
. The Core Contract receives the state update.
. The message is cleared from the Core Contract's storage to consume the message. Clearing the Core Contract's storage does the following:
+
* incurs a fixed cost of 5,000 L1 gas
* emits an L1 event logging the message consumption

At this point, the message is handled.

An L1->L2 message consists of the following:

* L1 sender's address
* L2 recipient's contract address
* Function selector
* Calldata array
* Message nonce
+
[NOTE]
====
The message nonce is maintained on the Starknet Core Contract on L1, and is incremented whenever a message is sent to L2. The nonce is used to avoid a hash collision between different L1 handler transactions that is caused by the same message being sent on L1 multiple times.

For more information, see xref:#l1_l2_message_structure[L1->L2 structure].
====

=== L1 -> L2 message structure


For completeness, the following table describes the precise structure of both the message as it appears on L1 and the induced transaction as it appears on L2:

[%autowidth.stretch]
|===
| FromAddress       | ToAddress      | Selector       | Payload              | Nonce          |

| `EthereumAddress` | `FieldElement` | `FieldElement` | `List+++<FieldElement>+++` | `FieldElement` |
|===

=== L1 -> L2 message hashing

The hash of the message is computed on L1 as follows:

[source,js]
----
keccak256(
    abi.encodePacked(
        uint256(FromAddress),
        ToAddress,
        Nonce,
        Selector,
        Payload.length,
        Payload
    )
);
----


=== L1 -> L2 message cancellation

[NOTE]
====
The flow described here should only be used in edge cases such as bugs on the Layer 2 contract preventing message consumption.
====

Consider that Alice sends an L1 asset to a Starknet bridge to transfer it to L2, which generates the corresponding L1->L2 message. Now, consider that the L2 message consumption doesn't function, which might happen due to a bug in the dApp's Cairo contract. This bug could result in Alice losing custody of their asset forever.

To mitigate this risk, the contract that initiated the L1->L2 message can cancel it by declaring the intent to cancel, waiting five days, and then completing the cancellation. This delay protects the sequencer from a DoS attack in the form of repeatedly sending and canceling a message before it is included in L1, rendering the L2 block which contains the activation of the corresponding L1 handler invalid.

The steps in this flow are as follows:

. The user that initiated the L1->L2 message calls the https://github.com/starkware-libs/cairo-lang/blob/4e233516f52477ad158bc81a86ec2760471c1b65/src/starkware/starknet/eth/StarknetMessaging.sol#L134[`startL1ToL2MessageCancellation`] function in the Starknet Core Contract.
. The user waits five days until she can finalize the cancellation.
. The user calls the https://github.com/starkware-libs/cairo-lang/blob/4e233516f52477ad158bc81a86ec2760471c1b65/src/starkware/starknet/eth/StarknetMessaging.sol#L147[`cancelL1ToL2Message`] function.



=== L1 -> L2 message fees

An L1 -> L2 message induces a transaction on L2, which, unlike regular transactions, is not sent by an account. This calls for a different mechanism for paying the transaction's fee, for otherwise the sequencer has no incentive of including L1 handler transactions inside a block.

To avoid having to interact with both L1 and L2 when sending a message, L1 -> L2 messages are payable on L1, by sending ETH with the call to the payable function `sendMessageToL2` on the Starknet Core Contract.

The sequencer takes this fee in exchange for handling the message. The sequencer charges the fee in full upon updating the L1 state with the consumption of this message.

The fee itself is calculated in the xref:architecture:fees.adoc#overall_fee[same manner] as
"regular" L2 transactions.

=== L1 handler transaction

==== Transaction fields

[%autowidth.stretch]
|===
| Version        | ContractAddress | Selector             | Calldata       | Nonce          |

| `FieldElement` | `FieldElement`  | `FieldElement` | `List+++<FieldElement>+++` | `FieldElement` |
|===

[NOTE]
====
In an L1 handler transaction, the first element of the calldata is always the sender's Ethereum address.
====

==== Hash calculation

The hash of the corresponding L1 handler transaction on L2 is computed as follows:

[source,cairo]
----
l1_handler_tx_hash = h(
    "l1_handler",
    version,
    contract_address,
    entry_point_selector,
    h(calldata),
    0,
    chain_id,
    nonce
)
----

Where:

* `l1_handler` is a constant prefix, encoded in bytes (ASCII), as big-endian.
* `version` is the transaction version. Only version 0 is currently supported.
* `chain_id` is a constant value that specifies the network to which this transaction is sent.
* _h_ is the xref:architecture:cryptography.adoc#hash-functions#pedersen_hash[Pedersen] hash (note that since we're hashing an array, the # of inputs needs to be appended to the hash).
* `0` indicates that L1 to L2 message fees are charged on L1.

==== Caveats and limitations

* Since L1 handler transactions are not initiated by an account, invoking https://github.com/starkware-libs/cairo/blob/2203a47f8a098cd4718d03bd109ca014049419e7/corelib/src/starknet/info.cairo#L49[`get_caller_address`^] or similar account-related functions returns the address `0x0`.
*  Starting from Starknet version 0.14.0:
** L1 handlers that fail execution will appear in a block as `REVERTED`, instead of only be written in the feeder gateway's database as `REJECTED`. The purpose of this change is to simplify the tracking of messages L1 -> L2, and the implementation of `getMessageStatus` in particular.
** The `l1_gas`, `l2_gas`, and `l1_data_gas` execution resources of L1 handlers will be bounded as follows:
*** `l2_gas` will bounded by stem:[10^8] (the same as ``++__validate__++``'s)
*** `l1_gas` and `l1_data_gas` will be bounded by stem:[4*10^4] and stem:[2*10^4], respectively (to allow for sending one L2 -> L1 message)

==== Supported versions
[cols=",,",]
|===
|Current version |Deprecated versions | Unsupported versions

| v0 | N/A | N/A
|===



================================================
FILE: modules/architecture/pages/os.adoc
================================================
[id="sn_os"]
= SNOS

== Overview

As an L2 validity rollup, Starknet's state on Ethereum can't be updated without proving that all the blocks between the current state and the new state are valid. SNOS (**S**tark**N**et **O**perating **S**ystem) is xref:what_is_snos?[the key element in Starknet's architecture] that xref:how_does_snos_work?[verifies the validity of Starknet blocks] and is required for xref:using_snos_to_update_starknets_state[
updating Starknet's state]. SNOS has two xref:implementations[implementations], a fully-open source one in Rust and a partially open-source one in Python.

[NOTE]
====
SNOS is a key element in Starknet's architecture, but also one of its more complicated components. Some parts may require reading more than once, but don't hesitate to https://github.com/starknet-io/starknet-docs/issues/new?assignees=landauraz&title=Feedback%20for%20%22The%20Starknet%20operating%20system%22[reach out^] if you feel further clarification is needed. 
====

== What is SNOS?

In Cairo, only statements of the form _"a specific Cairo program with specific inputs and produced specific outputs"_ can be proven, which means that the statement _"A Starknet block is valid"_ needs to expressed in the form of a Cairo program, inputs, and outputs.

This is where SNOS comes in: it is a Cairo Zero program that verifies the validity of blocks by getting an initial state and a list of transactions as input and outputting the state that is the result of applying these transactions on the initial state.

SNOS is the program required for updating Starknet's state on Ethereum (xref:#os-and-core-contract[up to some caveats]). As such, is it also the final arbiter on what does it mean for a transaction to execute correctly. For example, while a malicious sequencer can deviate from xref:architecture:transactions.adoc#transaction_flow[the `INVOKE` transaction's behavior] by skipping the execution of `+__validate__+` before `+__execute__+` in the calling account contract, this specification is https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os/execution/execute_transactions.cairo#L390[enforced by SNOS^] and therefore this sequencer will not be able to produce the proof for the block in which this transaction was included. 

== How does SNOS work?

=== High-level overview

The following is a rough sketch of the SNOS program, starting at https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os/os.cairo#L38[os.cairo]'s `main` function:

image::os_flow_copy.png[]

In broad strokes, SNOS's execution consists of the following steps:

. Preprocessing: preparing the SNOS's inputs, which include the various hints that will be needed throughout the execution (for example, 
the Merkle path of every accessed storage slot and the code of every accessed contract) 
. Running the transactions: the bulk of SNOS's execution, where transactions are executed sequentially such that for each transaction:
    * The associated account contract is loaded into the memory and called
    * Inner contracts are called, such that https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os/execution/execute_entry_point.cairo#L149[the entry `(contract_address, class_hash)` is added to a global state updates dictionary^] for each loaded contract (which is needed to assert that the loaded code corresponds to the class hash that is part of the state commitment)

+
[NOTE]
====
Contract calls are in fact done non-deterministically, i.e. the contract's response are guessed and verified later. For more details, see xref:#syscall-mechanism[Syscall mechanism].
====
    
    * State updates are accumulated in the global state updates dictionary
. Verifying that the new commitment corresponds to applying the updates accumulated in the global state updates dictionary to the old commitment (for more details, see the link:https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os/state/state.cairo#L40[`state_update` function in `state.cairo`^]).
. Encoding the state diff and adding it to the output segment for xref:data-availability.adoc[data availability] purposes (for more details, see the link:https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os/output.cairo#L71[`serialize_os_output` function in `output.cairo`^])

[id="syscall-mechanism"]
=== Syscall mechanism

A contract can invoke https://book.cairo-lang.org/appendix-08-system-calls.html[system calls^] throughout its execution, which pass the control from the currently executing contract to SNOS itself. Such operations are required when a contract needs information that does not exist within its code, e.g. accessing the Starknet state to read a storage value or to call another contract.

SNOS's code heavily relies on non-determinism to handle system calls. Whenever a contract invokes some syscall, the request, alongside the guessed response, is recorded in a syscalls array.
At the end of every entry point execution, we go over the syscalls array and verify that the responses were correct (for more details, see the https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os/execution/execute_entry_point.cairo#L286[`execute_entry_point` function in `execute_transactions.cairo`^]).

For syscalls such as https://book.cairo-lang.org/appendix-08-system-calls.html#get_execution_info[`get_execution_info`^], 
which returns the block hash and number, correctness means consistency with the value given to SNOS as input. For contract calls, however, one needs to execute the called contract and verify that the actual response and the guessed response are identical. But how can we guess the responses to all the contract calls before executing them? For that, it is important to distinguish two different styles-of-execution that a Starknet block goes through:

* The first one is done by a sequencer, when constructing the block from incoming transactions
* The second one is done by a prover, when executing SNOS in order to generate a proof for the (already finalized) block

Therefore, when running the OS, we already know what is going to happen: the block has already been executed by the sequencer, and so we know exactly what contracts and storage slots will be accessed, what each internal call will return, and so on.

It's worth noting that in the first execution, the sequencer can run in whatever way he chooses. In fact, he doesn't even have to run through the Cairo VM at all, but rather https://github.com/lambdaclass/cairo_native[precompile contracts to machine code and run them natively^]. Moreover, sequencers can also impose restrictions that are not enforced by SNOS. Such discrepancy between the two executions may seem like a bug, but as long as these restrictions only protect the sequencers themselves, rather than the correctness of execution, there is no reason for SNOS to enforce them. A good example for such restriction is the xref:architecture:accounts#limitations_of_validation[limits on validation functions] that protect the sequencer from DoS attacks. It is crucial, however, that both executions agree on the execution semantics, since, as mentioned in xref:#introduction[What is SNOS?], SNOS is the final arbiter and if it disagrees on the validity of the block, the sequencer will not be able to produce a proof for that block (and the only way forward would be a reorg on Starknet).

=== Multiblock input

Starting from Starknet version 0.14.0, block times on Starknet will be substantially shorter, leading to more frequent but also smaller blocks. As every run of SNOS on a single block incurs a fixed cost which is independent of the size of the block, producing e.g. twice as many blocks also doubles this fixed cost.

To mitigate this, SNOS will be modified in version 0.14.0 to receive multiple blocks as inputs. This also amortizes other non-negligible costs over a larger number of blocks: For example, if both block 10 and 11 use the same contract, SNOS loads and hashes its code only once instead of twice.

== Using SNOS to update Starknet's state

The Starknet Core contract is the contract responsible for storing and updating Starknet's state on Ethereum. As of Starknet v0.13.2 and as part of https://community.starknet.io/t/starknet-v0-13-2-pre-release-notes/114223#starknet-applicative-recursion-3[SHARP's applicative recursion feature^], proofs of SNOS's execution are not enough to update the Starknet Core contract. Instead, it is required to submit an "applicative proof" of a different program called https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/cairo/bootloaders/applicative_bootloader/applicative_bootloader.cairo#L15[the applicative bootloader^].

The way the applicative bootloader works is by verifying a proof of one or more executions of a base program stem:[B] and then using their outputs as input to an aggregator program stem:[A]. In the case of Starknet, stem:[B] is the SNOS program and stem:[A] is a new cairo program that squashes the state diffs of several blocks (the code of which can be found in the https://github.com/starkware-libs/cairo-lang/blob/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/aggregator/main.cairo#L8[cairo-lang GitHub repository^]). This way, individual executions of SNOS for some block range can be "squashed" into a single program whose valid execution attests to the validity of all blocks within that range and whose output is the squashed state diff of these blocks.

In order to verify that an "applicative proof" used the correct SNOS and aggregator programs, their program hashes must be stored in the Starknet Core contract. As each Starknet version is associated with a given SNOS program, this means that breaking protocol changes must be accompanied by an update to SNOS's (and possibly the aggregator's) program hash registered in the Starknet Core contract.

[TIP]
====
You can read the program hashes currently registered in the Starknet Core contract by using its https://etherscan.io/address/0xc662c410c0ecf747543f5ba90660f6abebd9c8c4#readProxyContract#F13[`programHash`^] (for SNOS's program hash) and https://etherscan.io/address/0xc662c410c0ecf747543f5ba90660f6abebd9c8c4#readProxyContract#F1[`aggregatorProgramHash`^] (for the aggregator's program hash) functions.
====

Finally, the Starknet Core contract is also responsible for verifying the few things that SNOS can't, including:

* Verifying that the state given to SNOS as input is Starknet's current state on Ethereum
* Verifying that all xref:architecture:messaging.adoc#l1-l2-messages[L1→L2 messages] were sent on Ethereum

== Implementations

The Cairo code of SNOS is available in the https://github.com/starkware-libs/cairo-lang/tree/8e11b8cc65ae1d0959328b1b4a40b92df8b58595/src/starkware/starknet/core/os[cairo-lang GitHub repository^]. 
However, this repository does not include all the hints implementation, which are necessary to locally run SNOS. The current implementation of these hints in Python is now deprecated, and will no longer be maintained in future Starknet versions.

[IMPORTANT]
====
As part of the transition of Starknet's infrastructure to Rust, SNOS's Pythonic hints implementation is deprecated, and will no longer be maintained in future Starknet versions.
====

Instead, a new Rust implementation of the hints, including initializing all inputs of SNOS via a Starknet full node connection, is available in the https://github.com/keep-starknet-strange/snos/tree/cb2a6d26faeb658492756fe100bbdf5b1600c768[SNOS GitHub repository^]. At the time of writing, this codebase supports the execution of SNOS for Starknet version 0.13.2.



================================================
FILE: modules/architecture/pages/overview.adoc
================================================
= Architecture overview

Welcome to the Architecture section of the Starknet Docs! 🏛️

Starknet is a coordinated system, with each element in its architecture playing a specific yet interconnected role.

As with other blockchains, everything starts with an xref:accounts.adoc[account]. On Starknet, accounts are smart contracts, a model which is known as native account abstraction. This allows for flexible authorization logic like multisig, session keys, or passkey-based authentication — all without changes to the protocol itself. When users want to interact with the network, they send xref:transactions.adoc[transactions]. These can invoke contract functions, deploy new contracts, or register new classes. Some transactions may involve communication between Ethereum and Starknet, which are handled through xref:messaging.adoc[L1↔L2 messaging] and enable secure bridges such as xref:starkgate.adoc[].

Periodically, transactions are collected and ordered into xref:blocks.adoc[blocks], which include a xref:cryptography.adoc[cryptographic] commitment the xref:state.adoc[state] of the network after executing them. To ensure that state transitions are valid, Starknet uses xref:sharp.adoc[SHARP] to generate and aggregate proofs of running the xref:os.adoc[SNOS] program. These proofs compress the entire block's execution into a succinct artifact which are submitted to Ethereum to be verified, so that Starknet's execution can be trusted without re-running it. Starknet also ensures access to the data involved in the computation through xref:data-availability.adoc[data availability], publishing compressed state diffs to Ethereum so the full state can be reconstructed and verified.

All of this — execution, proof generation, and L1 publishing — isn't free, which is where xref:fees.adoc[fees] come in. Users pay fees to cover the cost of using network resources, and these fees are paid in xref:strk.adoc[STRK], Starknet's native token. STRK is also used to power Starknet's xref:staking.adoc[staking protocol], where validators selected from STRK stakers help secure the sequencing layer and validate block production. This mechanism is designed to support decentralization and provide economic guarantees around block inclusion and ordering.

All together, these elements form a tightly integrated architecture, enabling scalable and expressive applications with low fees and strong security — all without compromising on decentralization or Ethereum alignment.

Now that you've got the big picture, put on your goggles and deep dive into whichever architectural pieces intrigue you most! 🤿



================================================
FILE: modules/architecture/pages/sharp.adoc
================================================
= SHARP

== Overview
SHARP is xref:what_is_sharp[StarkWare's proof aggregator], which uses xref:proof_recursion_in_sharp[proof recursion] and xref:sharp_and_s_two[the S-two prover] to make proving affordable for everyone, and is used by Starknet to reduce costs and improve efficiency within the network.

[TIP]
====
https://docs.herodotus.cloud/atlantic/introduction[Atlantic^] is a managed ZK Prover service that allows developers to easily integrate with SHARP.
====

.Additional resources
* https://starkware.co/blog/joining-forces-sharp/[_Save Costs and Enhance Ethereum's Scalability: If it's Written in Cairo, SHARP Can Prove it_^] on the Starknet blog
* https://www.youtube.com/watch?v=5kLm18E5ltg[_StarkWare's SHARP: Revolutionizing Ethereum Scaling with Recursive STARK Proofs_^] in the StarkWare Scalability Series
* https://www.youtube.com/watch?v=01tIeGBHsek[_SHARP: StarkWare's Shared Prover_^] from Starknet Summit 2023
* https://www.youtube.com/watch?v=VMNreeZkAgI[_SHARP - the backbone of Starknet_ Starknet^] and https://www.youtube.com/watch?v=jPxD9h7BdzU[_Introduction to SHARP verifier smart contact_^] community calls
* https://www.nethermind.io/blog/starknet-and-zksync-a-comparative-analysis[_Starknet and zkSync: A comparative analysis_^] by Nethermind
* https://blog.zksecurity.xyz/posts/stark-evm-adapter/[_Verifying Cairo proofs on Ethereum_^] by zkSecurity
* https://blog.lambdaclass.com/proof-aggregation-techniques/[_Proof aggregation techniques_^] by LambdaClass

== What is SHARP?
Being a provable programming language, Cairo allows generating STARK proofs for the validity of its execution, which can then be verified onchain to guarantee their correctness. SHARP (SHARed Prover) is a powerful system designed to generate a unified STARK proof for multiple Cairo programs and verify it on Ethereum. Leveraging the exponential asymmetry of the STARK protocol, this allows applications to share the cost of verifying proofs onchain with other applications, as well as "break down" their computations into several smaller computations without increasing costs.

For Starknet, this results in sending only a single proof per multiple blocks to Ethereum, and paying for its onchain verification only with respect to their relatize share in it.

== How does SHARP work?

=== High-level overview
SHARP's architecture consists of several services that work together to generate proofs, which include:

. The Gateway, through which external _Cairo position-independent executions (Cairo PIEs)_ can be submitted to SHARP

. The Job Creator, which processes external Cairo PIEs into _jobs_ and prevents duplications

. The Validator, which runs validation checks on each job, ensuring they can be proven successfully

. The Scheduler, which determines which Cairo job are to be aggregated together

. The Cairo Runner, which executes Cairo jobs and creates their Cairo PIEs

. The Prover (xref:stone_and_s_two[either Stone or Stwo]), which generates STARK proofs of Cairo PIEs

. The Dispatcher, which either packages proofs before sending them onchain, or xref:proof_recursion[verifies them using the Cairo verifier, creates a corresponding recursive job, and sends it back to the validator]

. The Blockchain Writer, which is responsible for sending packages from the dispatcher xref:onchain_verifier[onchain for verification]

. The Catcher, which monitors onchain transactions to ensure that they have been accepted

The following is a high-level overview of SHARP's architecture flow:

image::sharp-architecture.png[]

=== Stone and S-two
SHARP uses https://starkware.co/blog/open-sourcing-the-battle-tested-stone-prover/[StarkWare's first-gen Stone prover^] to generate STARK proofs for all proofs it aggregates.

Starting from Starknet version 0.14.0, SHARP will use https://starkware.co/blog/s-two-prover/[StarkWare's next-gen S-Two prover^] for generating all proofs except those of xref:proof_recursion[recursive tree roots], which will still to be generated using Stone. Continuing to use Stone for proving recursive tree roots is done to avoid changing SHARP's xref:onchain_verifier[onchain verifiers].

=== Proof recursion
Since its inception, SHARP has undergone a handful of efficiency upgrades, with the most powerful being the shift from a linear to a recursive model.

In the linear model, SHARP waited for enough programs to "fill up" a proof, and only then started the proving process for the whole bundle of programs.

In the recursive model, SHARP proves each statement upon its arrival, and instead of verifying it onchain, it verifies it offchain using a verifier program written in Cairo. Each two of execution of the this verifier program are then aggregated into a single proof, and are then sent back to SHARP and the Cairo verifier, restarting the process. This continues recursively, with each new proof being sent to the Cairo verifier until a trigger is reached. At this point, the last proof in the series is sent to the Solidity verifier on Ethereum.

At first glance, recursive proofs may seem more complex and time-consuming. However, there are several benefits to this approach:

. Parallelization: Recursive proofs enable work parallelization, reducing user latency and improving SHARP efficiency
. Cheaper onchain costs: Parallelization enables SHARP to create larger proofs, which in turn result in reduced onchain costs
. Lower cloud costs: Since each job is smaller, the required memory for processing is reduced, resulting in lower cloud costs
. Cairo support: Recursive proofs only require support in Cairo, without the need to add support to the onchain verifiers

=== Onchain verifier
SHARP's onchain verifiers is a set of multiple smart contracts responsible for verifying STARK proofs generated by SHARP, the key of which are:

* https://etherscan.io/address/0x47312450b3ac8b5b8e247a6bb6d523e7605bdb60[`GpsStatementVerifier`^], which serves as the primary verifier contract and relies on smaller verifier contracts that contain specific verification logic.
+
[NOTE]
====
For future enhancements or adjustments, a https://etherscan.io/address/0x47312450B3Ac8b5b8e247a6bB6d523e7605bDb60[`Proxy`^] and https://etherscan.io/address/0xD4C4044ACa68ebBcB81B13cC2699e1Bca2d3F458[`CallProxy`^] contracts are used allow seamless updates to the `GpsStatementVerifier` without compromising its foundational logic.
====

* https://etherscan.io/address/0xfd14567eaf9ba941cb8c8a94eec14831ca7fd1b4[`MemoryPageFactRegistry`^], which maintains hashes of the proven programs' memory pages, primarily used to register outputs for data availability

* https://etherscan.io/address/0x5899efea757e0dbd6d114b3375c23d7540f65fa4[`MerkleStatementContract`^], which verifies the Merkle paths in the STARK proof

* https://etherscan.io/address/0x3e6118da317f7a433031f03bb71ab870d87dd2dd[`FriStatementContract`^], which is responsible for verifying the FRI layers in the STARK proof

The verification flow consists of the following steps:

. The Dispatcher sends:

* Memory pages (usually many) to the `MemoryPageFactRegistry` contract

* Merkle statements (typically between 3 and 5) to the `MerkleStatementContract` contract

* Fri statements (generally ranging from 5 to 15) to the `FriStatementContract` contract

. The Dispatcher send the proof to the `GpsStatementVerifier` contract

. Starknet monitors the `GpsStatementVerifier` contract and updates its state once verification is complete



================================================
FILE: modules/architecture/pages/staking.adoc
================================================
= Staking

[IMPORTANT]
====
The Starknet Improvement Proposal (SNIP) for Bitcoin staking on Starknet is now https://community.starknet.io/t/snip-31-bitcoin-staking-on-starknet/115696[live^]!

Jump into the discussion and help shape the future of Starknet's decentralization 🌐
====

== Overview

While Starknet is currently still centralized, it is xref:roadmap[gradually] moving towards employing a xref:protocol[staking protocol], handing over the responsibilities of producing, attesting, and proving blocks to validators. To facilitate this gradual implementation, the protocol's architecture is divided into several xref:components[components], ensuring maximum flexibility and ease of upgrades. However, anyone holding STRK in their wallets can already stake their tokens and earn rewards based on their level of participation by following xref:procedures[a few simple steps]. 

[TIP]
====
If you are only interested in learning how to stake on Starknet, feel free to skip straight to xref:procedures[].
====

.Additional resources

* Staking dashboards by https://www.aligned-stake.com/[AlignedStake^], https://dashboard.endur.fi/[Ednur^], https://www.stakingrewards.com/stake-app?input=starknet[Staking Rewards^], https://starkscan.co/staking[Starkscan^], and https://voyager.online/staking-dashboard[Voyager^]
* https://www.starknet.io/staking[Staking^] on starknet.io
* https://github.com/starkware-libs/starknet-staking/tree/%40staking/contracts-v1.0.1-dev.510[`starknet-staking`^] on GitHub (deployed tag)
* https://www.starknet.io/blog/staking-phase-1/[Starknet launches phase 1 of its staking initiative on mainnet^] on the Starknet blog
* https://community.starknet.io/t/snip-28-staking-v2-proposal/115250[SNIP 28: Staking V2 proposal^] on the Starknet community forum

== Roadmap

Naturally, handing over the responsibility for maintaining and securing Starknet to validators in one day is neither feasible nor desirable. Instead, the staking protocol is implemented in incremental phases, with each phase bringing additional requirements from validators until they fully maintain and secure the network. The protocol is currently in the second of four phases, illustrated in following figure:

[IMPORTANT]
====
The staking protocol is currently in its second phase on both Sepolia and Mainnet.
====

image::staking-roadmap.png[]

== Protocol

The following sections describe the details of Starknet's staking protocol. The parameters used in the protocol are summarized in the following table:

[%autowidth]
|===
| Parameter | Mainnet | Sepolia

| Minimum stake for validators
| 20K STRK
| 1 STRK

| Minting curve yearly inflation cap (stem:[C])
| 1.6%
| 1.6%

| Withdrawal security lockup
| 21 days
| 5 minutes

| Epoch length (stem:[E])
| 120 blocks
| 40 blocks

| Epoch duration
| 3600 seconds
| 1200 seconds

| Attestation window (stem:[W])	
| 16 blocks
| 16 blocks

| Number of epochs used for latency (stem:[k])
| 1 epoch
| 1 epoch
|===

=== Roles

Starknet's staking protocol features two options for participation:

* Staking directly as validators: Staking a minimum of 20,000 STRK and earning rewards by handling any responsibilities the protocol requires

* Staking indirectly as delegators: Delegating STRKs to validators who allow delegation and sharing in their rewards without handling any of their responsibilities
+
[NOTE]
====
Validators can choose whether to allow delegation or not.
====

=== Addresses

To reduce exposure to threats and enhance security, multiple addresses for defined for both validators and delegators:

* Validator addresses:

** Staking address: Used for staking, adding stake, and unstaking. This address is only needed when entering or exiting the protocol and handles large amounts of STRK, and therefore is best kept by a cold wallet with minimal activity.

** Rewards Address: Used for receiving rewards. This address is only needed when receiving rewards, and therefore is best kept by a cold wallet.

** Operational Address: Used for operational purposes, such as block attestations (starting from the protocol's second phase), block proposing (starting from the protocol's third phase), etc. This address is used frequently and doesn't handle large amounts of funds, and therefore is best kept by a hot wallet. Starting from the protocol's second phase, however, hacking the operational address can lead to a lose of yield for the validator and its delegators.

* Delegator addresses:

** Staking address: Used for delegating stake, adding stake and unstaking. This address is only needed when entering or exiting the protocol and handles large amounts of STRK, and therefore is best kept by a cold wallet with minimal activity.

** Rewards Address: Used for receiving rewards. This address is only needed when receiving rewards, and therefore is best kept by a cold wallet.

The protocol uses a hierarchical approach between the staking and rewards addresses, and both validators and delegator can also use their staking address whenever their rewards address is required.

=== Epochs

Starting from its second phase, the staking protocol introduces the notion of _epochs_ (similarly to many other protocols). Epochs represent checkpoints where validators' stakes are set, such that changes made in epoch stem:[i] are applied in epoch stem:[i+k], where stem:[k] is a new latency parameter. For example, the following figure illustrates a scenario where in epoch stem:[i] validator stem:[A] has 50K STRK staked and someone delegates an additional 10K STRK to them, and in epoch stem:[i+1] someone undelegates 30K STRK from stem:[A]: 

image::epochs-example.png[]

=== Responsibilities

==== Running a full node

The staking protocol requires validators to run one of the following full node implementations:

[%autowidth]
|===
| Name | Hardware requirements | Integration guide

| Juno
| https://juno.nethermind.io/hardware-requirements[juno.nethermind.io/hardware-requirements^]
| https://juno.nethermind.io/running-juno[juno.nethermind.io/running-juno^]

| Madara
| https://docs.madara.build/hardware[docs.madara.build/hardware^]
| https://github.com/madara-alliance/madara/blob/main/README.md#%EF%B8%8F-installation[github.com/madara-alliance/madara/README.md^]

| Pathfinder
| https://eqlabs.github.io/pathfinder/getting-started/hardware-requirements[eqlabs.github.io/pathfinder/getting-started/hardware-requirements^]
| https://eqlabs.github.io/pathfinder/getting-started/running-pathfinder[eqlabs.github.io/pathfinder/getting-started/running-pathfinder^]
|===

==== Block attestation

Starting from its second phase, the staking protocol requires validators to attest to blocks, by running one of the following software:

* https://github.com/NethermindEth/starknet-staking-v2/blob/main/README.md[Starknet Staking v2^] by Nethermind
* https://github.com/eqlabs/starknet-validator-attestation/blob/main/README.md[Starknet Validator Attestation^] by Equilibrium

.How does the block attestation mechanism work?

In each epoch, each validator is assigned a single block whose relative number within the epoch is defined as follows:

[stem]
++++
h(\text{staked amount},\text{epoch id},\text{validator address}) \mod (E-W)
++++

where:

* stem:[E] is the number of blocks in an epoch, termed _epoch length_
* stem:[W] is the number of blocks applicable for attestation submittal, termed _attestation window_

During each epoch, validators have the opportunity to attest to their assigned block by submitting an `attest` transaction, which must be included within the attestation window. For example, if stem:[W = 20] and stem:[N] is the relative block number assigned to validator stem:[A], then stem:[A] must submit an `attest` transaction between the blocks whose relative number within the epoch are stem:[N+1] and stem:[N+20].

[NOTE]
====
In the second phase of the protocol, each Validator is required to perform only one attestation per epoch.
====

The `attest` transaction includes the block hash of the attested block, ensuring validators actively use full nodes, as they need to continuously track block hashes. Additionally, the attestation is publicly verifiable, ensuring validators' reliability is publicly tested — a crucial prerequisite before handing them any core responsibilities.

=== Rewards

Rewards are distributed based on the amount staked and the commission policy constant stem:[CP] set by the validator, with yearly reward percentages calculated using the following formulas:

* For delegators:
+
[stem]
++++
\text{stake_delegated} \cdot (1 - CP) \cdot \frac{M}{S}
++++

* For validators:
+
[stem]
++++
\left(\text{self_stake} + \text{total_stake_delegated} \cdot CP\right) \cdot \frac{M}{S}
++++

where stem:[M] and stem:[S] are defined by the xref:#minting_curve[].

Starting from the second phase of the protocol, rewards are accumulated per epoch only for validators who performed their attestations in the epoch on an “all or nothing” basis — so validators that submitted a transaction during the epoch that proves they tracked the network will receive all the rewards for the epoch based on their staked amount, while validators that didn't will get no rewards for the epoch's entire duration. After performing the attestation, the rewards that go directly to the validator will accumulate in his account, and the rest will go to this validator's pool. Stakers that enter the protocol on epoch stem:[i] will start getting rewards only on epoch stem:[i+k], and stakers that signal an intent to exit the protocol on epoch stem:[i] will still get rewards until epoch stem:[i+k-1].



[NOTE]
====
Starting from the second phase of the protocol, when a delegator claims his rewards, all rewards they received from all epochs since the last time they claimed rewards will be accumulated. The complexity of this operation is stem:[O(\text{#delegator's balance changes since last claim})] — and not stem:[O(\text{#epochs since last claim})] — which is assumed to be small enough to fit in one transaction in any real-world-scenario. This mechanism replaces the global reward index that was used prior to the protocol's second phase.
====

==== Minting curve

The minting curve balances participation and inflation by adjusting rewards based on the total STRK locked in the protocol, and is defined by the following formula:

[stem]
++++
M = \frac{C}{10} \times \sqrt{S}
++++

where:

* stem:[S] is the staking rate as a percentage of the total token supply
* stem:[M] is the annual minting rate as a percentage of the total token supply
* stem:[C] is the maximum theoretical inflation percentage, set to 1.6%

=== Latencies

The following latencies are set in place:

* To disincentivise sudden large withdrawals that could destabilize the network, funds are subject to a 21-day lockup after signaling an unstake intent, during which no rewards are earned and funds cannot be withdrawn. 

* Starting from the second phase of the protocol, to prevent delegator from switching too quickly between validators while still promoting a competitive delegation market, a switch intent that is signaled on epoch stem:[i] takes effect only on epoch stem:[i+1].

=== Commissions

Starting from its second phase, the staking protocol allows validators to increase their commission. To avoid an unexpected increase in commissions, validators must commit to a certain maximum commission stem:[M] and the last date (in epochs) that this commitment is relevant for. Until this date arrives, validators cannot increase their commission beyond stem:[M], but can freely change their commission in the range stem:[[0,M\]].

== Components

The implementation of Starknet's staking protocol is divided into several contracts, summarized in the following figure:

image::staking-architecture.png[]

This modular architecture allows for targeted upgrades and improvements without affecting the entire system. Access control mechanisms are also in place to ensure that only authorized parties can make critical changes, further enhancing the security of the staking process. The following table details the key components of the protocol:

[cols="1,8"]
|===
| Contract | Description

| Staking
| The staking contract is the core of the staking system, managing the entire lifecycle of staking, from initial staking to claiming rewards and unstaking. 

The staking contract also stores the `StakerInfo` data structure, which holds detailed information about each validator, including their staked amount, unclaimed rewards, delegation details, and operational parameters, and helps to ensure that validators' information is accurately tracked and updated.

| Delegation pooling
| All delegation interactions, such as entering or exiting a pool, are enabled through the delegation pooling contract, which tracks each delegator's contribution, calculates their rewards, and manages the delegation lifecycle.

The delegation pooling contract also stores the `PoolMemberInfo` data structure, which holds information about each delegator's contributions, rewards, and status within the pool, and helps manage and calculate the delegation and reward distribution processes for pool members.

| Reward Supplier
| The reward supplier contract is responsible for calculating and supplying the staking rewards based on the minting curve, ensuring the rewards are distributed fairly and in accordance with the protocol's economic parameters.

| Minting Curve
| The minting curve contract defines the economic model that governs reward distribution, ensuring that the network's inflation is managed while incentivizing participation of stakers.

| Attestation
| The attestation contract manages the tracking of successful validator attestations, by verifying whether the validator has correctly attested to their assigned block within a designated attestation window.
|===

== Procedures

The following tables detail the procedures enabled by the staking protocol for both xref:staking_as_validators[validators] and xref:staking_as_delegators[delegators], along with the instructions to perform them.

To invoke onchain contracts, use https://foundry-rs.github.io/starknet-foundry/starknet/sncast-overview.html[Starknet Foundry's `sncast`^], xref:tools:overview.adoc[Starkli], or a xref:ecosystem:overview.adoc[block explorer]. To get the onchain addresses of the staking and STRK contracts, see xref:resources:chain-info.adoc#staking[Important addresses].

=== Staking as validators

[cols="1,2,2"]
|===
| Procedure | Instructions | Notes

| Staking
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#stake[`stake`^] function
a| * You should make sure you are xref:responsibilities[running a full node and attesting to blocks] before staking
* You must first approve the transfer of the amount of STRK tokens to be staked to the staking contract by invoking the STRK contract's `approve` function
* `operational_address` should have sufficient funds to pay for attestation transactions
* `amount` should be equal or greater than the xref:protocol[minimum stake for validators] and denominated in FRI (i.e., 1*10^18^ = 1 STRK)
* `commission` should be entered as a percentage with precision, where 10,000 represents 100% (e.g., to set a 5% commission, you enter 500)

| Claiming rewards
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#claim_rewards[`claim_rewards`^] function
|

| Increasing stake
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#increase_stake[`increase_stake`^] function
a| * `amount` should be denominated in FRI (i.e., 1*10^18^ = 1 STRK)
* You must first approve the transfer of STRK tokens to the staking contract by invoking the STRK contract's `approve` function

| Setting commission
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#set_commission[`set_commission`^] function
a| * `commission` should be entered as a percentage with precision, where 10,000 represents 100% (e.g., to set a 5% commission, you enter 500)
* Commissions can be increased only after xref:commissions[setting a commission commitment] using https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#set_commission_commitment[`set_commission_commitment`^]

| Changing reward address
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#change_reward_address[`change_reward_address`^] function
|

| Changing operational address
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#declare_operational_address[`declare_operational_address`^] and https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#change_operational_address[`change_operational_address`^] functions
| `declare_operational_address` should be invoked by your new operational address and `change_operational_address` should be invoked by your staking address

| Opening delegation
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#set_open_for_delegation[`set_open_for_delegation`^] function
| Opening delegation is necessary only if `pool_enabled` was set to `false` when invoking the staking contract's `stake` function

| Unstaking
| Invoke the staking contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#unstake_intent[`unstake_intent`] and https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#unstake_action[`unstake_action`] functions
a| * Once an unstake intent is signaled:
** Funds are removed from the total balance and are no longer part of the staking protocol
** The same staking address cannot be used to "restake" (i.e., `unstake_action` is *irreversible*)
* `unstake_action` should be invoked only after the appropriate xref:latencies[waiting period] has ended

|===

=== Staking as delegators

[IMPORTANT]
====
The following procedures are only intended for developers who are either interested (for whatever reason) in staking as delegators without using a xref:introduction[staking dashboard], or are building one.
====

[cols="1,2,2"]
|===
| Procedure | Instructions | Notes

| Entering a delegation pool
| Invoke the delegation pool contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#enter_delegation_pool[`enter_delegation_pool`^] function
a| * `amount` should be denominated in FRI (i.e., 1*10^18^ = 1 STRK)
* You must first approve the transfer of STRK tokens to the delegation pool contract by invoking the STRK contract's `approve` function

| Claiming rewards
| Invoke the delegation pool contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#claim_rewards-1[`claim_rewards`^] function
|

| Adding to a delegation pool
| Invoke the delegation pool contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#add_to_delegation_pool[`add_to_delegation_pool`^] function
a| * `amount` should be denominated in FRI (i.e., 1*10^18^ = 1 STRK)
* You must first approve the transfer of STRK tokens to the delegation pool contract by invoking the STRK contract's `approve` function

| Switching delegation pools
| Invoke the delegation pool contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#switch_delegation_pool[`switch_delegation_pool`^] function
|

| Changing reward address
| Invoke the delegation pool contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#change_reward_address-1[`change_reward_address`^] function
|

| Exiting a delegation pool
| Invoke the delegation pool contract's https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#exit_delegation_pool_intent[`exit_delegation_pool_intent`^] and https://github.com/starkware-libs/starknet-staking/blob/main/docs/spec.md#exit_delegation_pool_action[`exit_delegation_pool_action`^] function
| `exit_delegation_pool_action` should be invoked only after the appropriate xref:latencies[waiting period] has ended
|===



================================================
FILE: modules/architecture/pages/starkgate.adoc
================================================
[id="StarkGate_architecture"]
= StarkGate

== Overview

https://starkgate.starknet.io[StarkGate^], developed by StarkWare, bridges ETH and ERC-20 tokens between Ethereum and Starknet. Its various xref:components[components] enable anyone to easily xref:procedures[deposit funds to Starknet (with and without a message attached), withdraw funds to Ethereum, and add a token to StarkGate].

[IMPORTANT]
====
Following https://twitter.com/MakerDAO/status/1746977683190251591?s=20[Maker DAO's announcement^], StarkWare launched a new set of DAI bridge and token contracts under StarkGate. This new DAI token retains the same contract 'symbol' and 'name' as the existing one, and to differentiate between the two, the old DAI is referred to as “DAI v0” while the new DAI is simply referred to as “DAI”.

Withdrawal of DAI v0 tokens is still possible with no limitations, but depositing DAI v0 using the DAI v0 bridge is disabled. Users are *strongly* encouraged to migrate to the new DAI token, as it cannot support StarkGate's latest features (such as Smart Deposits and Withdrawal Limits) and will stop being compatible with Starknet altogether over time.

To migrate from DAI v0 to DAI, either swap your DAI v0 for DAI using one of Starknet's https://www.starknet.io/dapps/?type=live&tags=216[swap apps and aggregators^] or withdraw your current DAI v0 tokens to L1 using and re-deposit them using StarkGate (which automatically issues the new DAI).
====

== Components

The following table details StarkGate's key components:

[cols="1,2", options="header"]
|===
| Contract
| Description

| Starknet Token Bridge

(on both L1 and L2)

| The primary StarkGate bridge contract, where the main user bridge functionality are defined.

| Starkgate Manager
| Responsible for adding tokens to the multi-bridge.


| Starkgate Registry
a| Contains the addresses of all supported bridges and tokens and enables to stop servicing an existing bridge.
[NOTE]
====
An interface to the Starkgate Registry is available through https://github.com/starknet-io/starkgate-contracts/tree/v2.0.1/src/solidity/IStarkgateRegistry.sol[`IStarkgateRegistry.sol`].
====

| Starkgate Service
| An interface to check if a contract is servicing a token.
|===

In addition, prior to StarkGate 2.0 (Mainnet: January 2024) tokens were bridged with a unique and custom pair of L1 and L2 bridge contracts, where the L1 contract is an instance of https://github.com/starknet-io/starkgate-contracts/blob/cairo-1/src/solidity/LegacyBridge.sol[`LegacyBridge.sol`^] and the L2 contract is an instance of https://github.com/starknet-io/starkgate-contracts/blob/cairo-1/src/cairo/legacy_bridge_eic.cairo[`legacy_bridge_eic.cairo`^]. These legacy token bridges are supported by StarkGate 2.0 in a fully backward-compatible fashion.

[NOTE]
====
For example, the https://etherscan.io/address/0xf6080d9fbeebcd44d89affbfd42f098cbff92816#writeProxyContract[L1 bridge contract for USDC^] has the following two `deposit` functions:

[horizontal,labelwidth="25"]
`deposit (0x0efe6a8b)`:: The multi-bridge contract, which includes support for all tokens within a single contract, requiring that you enter the address of the token in the deposit function.
`deposit (0xe2bbb158)`:: The legacy contract, which is labeled *Support Legacy ABI*. This function does not include the `token (address)` parameter, because the contract that contains this function only supports USDC. Therefore, the address of the token is superfluous.

For the complete list of legacy bridges, see the https://github.com/starknet-io/starknet-addresses/tree/master/bridged_tokens[`bridged_tokens`^] directory on GitHub.
====

The following is an overall illustration of StarkGate's various components:

image::sg-architecture.png[]

== Procedures

The following sections detail the procedures enabled by StarkGate, along with the instructions to perform them.

[IMPORTANT]
====
For adding a token to Starknet, see https://9oelm.github.io/2024-03-28-making-sense-of-starknet-architecture-and-l1-l2-messaging/#enroll-a-token-bridge[Joel Mun's blog^].

Note that enrolling a new bridge does not add it to StarkGate's GUI.
====

All procedures are subject to xref:architecture:messaging.adoc#l1-l2-message-fees[fees] to account for L1->L2 message costs. Fees for depositing funds or enrolling a token bridge on StarkGate can be estimated using the xref:resources:starkgate-reference.adoc#estimateDepositFeeWei[`estimateDepositFeeWei`] or xref:resources:starkgate-reference.adoc#estimateEnrollmentFeeWei[`estimateEnrollmentFeeWei`] function.

To invoke onchain contracts, use https://foundry-rs.github.io/starknet-foundry/starknet/sncast-overview.html[Starknet Foundry's `sncast`^], xref:tools:overview.adoc[Starkli], or a xref:ecosystem:overview.adoc[block explorer]. To get the onchain addresses of StarkGate's contracts, see xref:resources:chain-info.adoc#starkgate[Important addresses].

For more information on StarkGate's various functions, see xref:resources:starkgate-reference.adoc[StarkGate functions and events].

=== Depositing funds

Using StarkGate to deposit L1 funds into the L2 Starknet requires StarkGate's `deposit` function. The `deposit` function does the following:

. Transfers the funds from the user's Ethereum account to the StarkGate L1 contract.
. Emits a `Deposit` event that includes the L1 and L2 addresses of the user, and the amount deposited.
. Sends a message to the corresponding L2 bridge with the amount deposited, and the recipient's address.

Subsequently, the funds should be transferred to Starknet so that you can begin using them.

For more information on what happens during the transfer process, see xref:deposit_lifecycle[].

==== Cancelling a deposit

To ensure self-custody, StarkGate enables you to cancel a deposit if, after depositing funds with the `deposit` function on L1, you don't see your funds appear on L2 within a reasonable amount of time.

In order to guard against an attack, it takes approximately five days to cancel a deposit. From the moment StarkGate receives the cancellation request, a counter begins. When exactly five days have passed, and the funds still do not appear on L2, you can reclaim the deposit.

To cancel a deposit, call the `depositCancelRequest` request function. When StarkGate receives the cancellation request, a counter begins to count five days. When exactly five days have passed, and the funds still do not appear on L2, you can reclaim the deposit by calling `depositReclaim`.

[NOTE]
====
As long as the `depositReclaim` was not performed, the deposit may be processed, even if
the cancellation delay time has already passed.

Only the depositor is allowed to cancel
a deposit, and only before depositReclaim was performed.
====

==== Depositing funds with a message

A deposit with a message is a deposit that moves funds from L1 to L2 and then triggers subsequent actions. For example, a user can deposit funds and transfer those funds to another recipient, such as an exchange.

The `depositWithMessage` function enables sending a deposit with a message. `depositWithMessage` is similar to the `deposit` function, with an additional 256-bit message, which can contain instructions for executing additional actions.

Upon completion, the `depositWithMessage` function triggers a call to a callback function, named `on_receive`, on the L2 contract that receives the deposit. The `on_receive` function receives the deposit message as input.

`on_receive` must return `true` for the deposit to succeed. If `on_receive` returns `false`, or if the recipient contract does not include the `on_receive` function, the `depositWithMessage` function's L1 handler fails. The user can recover their funds using the `depositWithMessageCancelRequest` function.

To enable deposits with messages in your application:

. Implement the `on_receive` function in the L2 contract that should receive deposits.
. Use the `depositWithMessage` function to transfer funds from L1 to L2.

==== Deposit lifecycle

.Step 1: Initiating a deposit on L1

. A call to the L1 `deposit` function initiates a deposit.
. The function does the following:
+
--
* Transfers the funds from the user's account to the Starknet bridge.
* Emits a `Deposit` event that includes the L1 and L2 addresses of the user, and the amount deposited.
* Sends a message to the corresponding L2 bridge with the amount deposited, and the recipient's address.
--
+
Starknet's sequencer is now aware of the deposit transaction.

. The sequencer waits for enough L1 block confirmations to fill its quota to run before the corresponding deposit transaction is initiated on L2. During this period of time, the status of the L2 deposit transaction is xref:transactions.adoc#transaction_lifecycle[`NOT_RECEIVED`].

.Step 2: Triggering a deposit on L2

. The sequencers refer to the deposit
request by triggering the L1 handler using the
https://github.com/starkware-libs/starkgate-contracts/blob/28f4032b101003b2c6682d753ea61c86b732012c/src/starkware/starknet/apps/starkgate/cairo/token_bridge.cairo#L135[`handle_deposit`^] function on the L2 bridge.

. The `handle_deposit` function verifies that the deposit indeed came from the corresponding L1 bridge. It then calls the relevant token's contract on Starknet and mints the specified amount of the token on L2 for the user.

. The sequencers complete constructing the block.

The status of the deposit request is now xref:transactions.adoc#transaction_lifecycle[`ACCEPTED_ON_L2`].

.Step 3: Proving the block that includes the deposit

. Starknet's provers prove the validity of the block and submit a state update to L1.

. The message confirming transfer of the funds is cleared from the Starknet Core Contract, and the fact that the user has transferred their funds is part of the now finalized state of Starknet.

[NOTE]
====
If the message wasn't on L1 to begin with, that is, if the deposit request was fraudulently created on Starknet, the state update fails.
====

=== Withdrawing funds

Using StarkGate to withdraw funds from Starknet requires StarkGate's `initiate_token_withdraw` function to initiate a withdrawal. The function does the following:

* Burns the transferred amount of tokens from the L2 balance of the withdrawal's initiator.
* Sends a message to the relevant L1 bridge with the amount to be transferred and the recipient's Ethereum address.

Subsequently, the funds should be transferred to the recipient's Ethereum address, and should be available after the next L1 state update.

For more information on what happens during the transfer process, see xref:withdrawal_lifecycle[].

==== Withdrawal limit

By default, StarkGate imposes no limit on withdrawals. However, in order to mitigate risks associated with critical vulnerabilities that could result in the loss of user funds, StarkGate can enable a withdrawal limit.

If a serious security issue arises, the security agent in the StarkGate contract can limit withdrawals to 5% of the Total Value Locked (TVL) per day for any affected token by calling the `setWithdrawLimitPCT()` function in the `WithdrawalLimit.sol` contract. A dedicated team can then investigate and resolve the issue.

Only a security admin quorum can disable the withdrawal limit. The quorum will consist of Starknet Foundation members, Starknet ecosystem contributors, and StarkWare representatives. This diverse group will ensure that decisions reflect the Starknet community's broad interests.

This approach, blending manual oversight with automated detection, aims to minimize potential losses.

==== Withdrawal lifecycle

.Step 1: Initiating a withdrawal on L2

. A call to the L2 `initiate_token_withdraw` function initiates a withdrawal.
. The function does the following:
* Burns the transferred amount of tokens from the balance of the withdrawal's initiator.
* Sends a message to the relevant L1 bridge with the amount to be transferred and the recipient's address.

.Step 2: Proving the block that includes the withdrawal

. The sequencer completes the block construction
. Starknet's provers prove the validity of the block and submit a state update to L1.
. The message from the previous step is stored in the Starknet Core Contract.

.Step 3: Transferring the funds on L1

After the withdrawal message has been recorded on the Starknet Core Contract, anyone can finalize the transfer on L1 from the bridge back to the user, by calling the `withdraw` function.

[NOTE]
====
This step is permissionless, anyone can do it. The recipient's address is part of the recorded message on L1, so they receive the funds regardless of who calls the `withdraw` function on L1.
====


================================================
FILE: modules/architecture/pages/state.adoc
================================================
= State

== Overview

Starknet's state xref:state_structure[is composed of contract classes and instances] and xref:state_transition[tracks any changes to them]. Its xref:state_commitment[commitment] uses a cryptographic structure optimized for zero-knowledge proofs, enabling efficient proof generation of state updates and forming the backbone of Starknet's scalability and security.

== State structure
Starknet's state consists of:

* A mapping between the hashes of contract classes and their definitions
* A mapping between the addresses of contract instances and their xref:contract_instance_state[states]

=== Contract instance state

A contract instance state consists of:

* A class hash, which defines the functionality of the contract
* A key-value mapping (where the key and values are field elements), which comprises the contract's storage
* A nonce, which tracks the number of transactions sent from this contract

=== Special addresses

Starknet uses special contract addresses to provide distinct capabilities beyond regular contract deployment.

Two such addresses are `0x0` and `0x1`. These addresses are reserved for specific purposes and are
characterized by their unique behavior in comparison to traditional contract addresses.

==== Address `0x0`

Address `0x0` functions as the default `caller_address` for external calls, including interactions with the L1 handler or deprecated Deploy transactions. Unlike regular contracts, address `0x0` does not possess a storage structure and does not accommodate storage mapping.

==== Address `0x1`

Address `0x1` is another special contract address within Starknet's architecture. It functions as a storage space for mapping block numbers to their corresponding block hashes. The storage structure at this address is organized as follows:

[horizontal,labelwidth="20"]
Keys:: Block numbers between stem:[\text{first_v0_12_0_block}] and stem:[\text{current_block - 10}].
Values:: Corresponding block hashes for the specified blocks.
Default Values:: For all other block numbers, the values are set to `0`.

The storage organization of address `0x1` supports the efficient retrieval of block hashes based on block numbers within a defined range and is also used by the https://book.cairo-lang.org/appendix-08-system-calls.html#get_block_hash[`get_block_hash`^] system call.

== State transition
A transaction stem:[$tx$] transitions the system from state stem:[$S$] to state stem:[$S'$] if:

* stem:[$tx$] is an `INVOKE` transaction, and the storage of stem:[$S'$] is the result of executing the target contract code with respect to the previous state stem:[$S$]. The arguments,
contract instance's address, and the specific function entry point are part of the transaction.
* stem:[$tx$] is a `DEPLOY_ACCOUNT` transaction, and stem:[$S'$] contains the new contract instance's state at the contract instance's address. Additionally, the storage of stem:[$S$] is updated
according to the execution of the contract instance's constructor.
* stem:[$tx$] is a `DECLARE` transaction, and stem:[$S'$] contains the class hash and definition in the contract class's mapping

== State commitment

The state commitment is a digest that represents the state.

In Starknet, the state commitment combines the roots of two binary xref:#merkle_patricia_trie[Merkle-Patricia tries] of height 251 in the following manner:

[,,subs="quotes"]
----
state_commitment = _h_~Pos~(
    "STARKNET_STATE_V0",
    contract_trie_root,
    class_trie_root
)
----

Where:

* `_h_~Pos~` is the xref:cryptography.adoc#poseidon_hash[Poseidon] hash
function.
* `STARKNET_STATE_V0` is a constant prefix string encoded in ASCII (and represented as a field element).
* `contract_trie_root` is the root of the xref:#contracts_trie[_contract trie_], a Merkle-Patricia trie whose leaves are the contracts' states.
* `class_trie_root` is the root of the xref:#classes_trie[_class trie_], a Merkle-Patricia trie whose leaves are the compiled class hashes.

[id="contracts_trie"]
=== The contract trie

As with Ethereum, this trie is a two-level structure, whose leaves correspond to distinct contracts. The address of each contract determines the path from the trie's root to its corresponding leaf, whose content encodes the contract's state.

The information stored in the leaf is as follows:

// [stem]
// ++++
// h(h(h(\text{class_hash}, \text{storage_root}), \text{nonce}),0)
// ++++

[,,subs="quotes"]
----
_h_~Ped~(
  _h_~Ped~(
    _h_~Ped~(
      class_hash,
      storage_root
    ), 
    nonce
  ),
  0
)
----


Where:

* `_h_~Ped~` is the xref:../cryptography.adoc#hash-functions#pedersen_hash[Pedersen] hash function.
* `class_hash` is the hash of https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html[the contract's definition^].
* `storage_root` is the root of another Merkle-Patricia trie of height 251 that is constructed from the contract's storage.
* `nonce` is the current nonce of the contract.

[id="classes_trie"]
=== The class trie

The class trie encodes the information about all existing
https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html[classes^] in Starknet's state. This trie maps https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html[class hashes^] to their
compiled class hashes. The information stored in a leaf at a path corresponding to some class hash is as follows:


[source,subs="quotes"]
----
_h_~Pos~(
    CONTRACT_CLASS_LEAF_V0,
    compiled_class_hash
)
----

Where:

* `_h_~Pos~` is the xref:../cryptography.adoc#poseidon_hash[Poseidon] hash function
* `CONTRACT_CLASS_LEAF_V0` is a constant prefix string encoded in ASCII (and represented as a field element).
* `compiled_class_hash` is the hash of the Cairo assembly resulting from compiling the given class via the Sierra-to-Casm compiler.

[#note_compiled_class_hash]
[NOTE]
====
.Compiled class hash

The compiled class hash identifies the output of a specific Casm compilation as unique.

Cairo classes that are part of the state commitment are defined with Sierra, an intermediate representation between Cairo and Cairo assembly (Casm). However, the prover only works with Casm.

So in order to prevent needing to compile from Sierra to Casm in every block in which the class is used, the state commitment must have some information about the corresponding Cairo assembly. The compiled class hash provides this information.

For more information, see https://book.cairo-lang.org/appendix-09-sierra.html[the Cairo Book^].

The party that declares the contract signs the compiled class hash, which they obtain using an SDK, as part of the xref:transactions.adoc#transaction_types[`DECLARE`] transaction. If the transaction is included in a block, then the compiled class hash becomes part of the state commitment.

In the future, when Sierra-to-Casm compilation becomes part of the Starknet OS, this value might be updated via a proof of the Sierra-to-Casm compiler execution, showing that compiling the same class with a newer compiler version results in some new compiled class hash.
====

[#merkle_patricia_trie]
=== Merkle-Patricia trie

The state commitment scheme uses a binary Merkle-Patricia trie with the Pedersen hash function.

[#about_nodes]
==== About nodes

Each node in the trie is represented by a triplet stem:[$(length, path, value)$], where:

[horizontal,labelwidth=10]
stem:[$length$]:: is the length of the path, measured in nodes.

stem:[$path$]:: is the path from the current node to its unique non-empty subtrie.
+
stem:[$path$] is an integer in the set stem:[$\{0,\ldots,2^{length}-1\}$], and the binary expansion of stem:[$path$] indicates how to proceed along the trie, as follows:
+
. Expand stem:[$path$] to its binary representation.
. Starting with the most significant bit, representing the root of the trie, traverse the tree node by node, where the bit values stem:[$0$] and stem:[$1$] indicate left and right, respectively.

stem:[$value$]:: is the value of the node, which can be either data, or the hash of two non-empty child nodes.

An empty node is one whose triplet values are stem:[$(0,0,0)$]. Leaf nodes and internal nodes can be empty. A subtrie rooted at a node stem:[$(length, path, value)$] has a single non-empty subtrie, rooted at the node obtained by following the path specified by stem:[$path$].

[NOTE]
====
Length is specified, and cannot be deduced from stem:[$path$], because the numbers in the triplet stem:[$(length, path, value)$] are field elements of fixed size, 251 bits each.

For a node where stem:[$length>0$], stem:[$path$] leads to the highest node whose left and right children are not empty.
====

==== Trie construction

The following rules specify how the trie is constructed from a given set of leaves:

The hash of a node stem:[$N =(length, path, value)$], denoted by stem:[$H(N)$], is:

[stem]
++++
H(N)=\begin{cases}
value, & \text{if } length = 0 \\
h_{Ped}(value, path) + length, & \text{otherwise}
\end{cases}
++++

[NOTE]
====
All arithmetic operations in the above description of stem:[$H$] are done in the STARK field, as described in xref:cryptography.adoc#stark-field[The STARK field].
====

==== Mathematical definition of the nodes in the trie

The triplet representing the parent of the nodes stem:[$left=(\ell_L, p_L, v_L)$], stem:[$right=(\ell_R, p_R, v_R)$] is defined as follows:

[stem]
++++
parent=
\begin{cases}
(0,0,0), & \text{if } left=right=(0,0,0)\\
(\ell_L + 1, p_L, v_L), & \text{if } right=(0,0,0) \text{ and } left \neq (0,0,0)\\
(\ell_R + 1, p_R + 2^{\ell_R}, v_R), & \text{if } right\neq (0,0,0) \text{ and } left = (0,0,0)\\
(0, 0, h_{Ped}(H(left), H(right))), & \text{otherwise}
\end{cases}
++++

==== Example trie

The diagram xref:#3-level_trie[] illustrates  the construction of a three-level-high Merkle-Patricia trie from the leaves whose values are stem:[$(0,0,1,0,0,1,0,0)$]:

[#3-level_trie]
.A three-level Merkle-Patricia trie
image::trie.png[3-level-high Merkle-Patricia trie]

Where stem:[$r=h_{Ped}(H(2,2,1),H((2,1,1))$]. Notice that the example does not skip from the root, whose length is zero, so the final state commitment to the trie is stem:[$H((0,0,r))=r$].

Suppose that you want to prove, with respect to the state commitment just computed, that the value of the leaf whose path is given by stem:[$101$] is stem:[$1$]. In a standard Merkle trie, the proof would consist of data from three nodes, which are siblings along the path to the root.

In a Merkle-Patricia trie, because the trie is sparse, you only need to send the two children of the root, which are stem:[$(2,2,1)$] and stem:[$(2,1,1)$]. These two children are enough to reproduce the state commitment stem:[$r$], and because you know that the height of the trie is three, and that it is fixed, you know that the path stem:[$01$] of length stem:[$2$] specified by the right-hand child, stem:[$(2,1,1)$], leads to the desired leaf.



================================================
FILE: modules/architecture/pages/strk.adoc
================================================
= STRK
:description: How token economics work in a block chain in general, and specifically in Starknet. The purpose of the Starknet token, its supply, and distribution.
:keywords: tokenomics, STRK, token economics, economic mechanisms of Starknet

== Overview

xref:background[Similar to other blockchains], Starknet uses the STRK token for xref:purposes[paying fees to enable operation of the network, maintaining and securing the network by enabling staking for consensus, and deciding on Starknet's values and technology goals by voting for governance proposals], of which xref:supply_and_distribution[ten billion tokens are planned to or have already been distributed].

[IMPORTANT]
====
The primary purpose of the Starknet token, STRK, is to facilitate operations and activities on Starknet and it is not intended to serve as an investment.
====

The economic mechanisms of STRK, also known as _tokenomics_, xref:risks_and_disclaimers[are subject to change based on governance decisions made by the larger community of Starknet and are described here for informational purposes only].

[TIP]
====
For more details on Starknet's governance processes, see the https://governance.starknet.io/[Starknet Governance Hub^].
====

== Background

Blockchains are valuable because they are data structures maintained by diverse and, ideally, large groups of otherwise unaffiliated persons. This gives them resilience: Any one participant can disappear, but the data structure is preserved. This also gives them censorship resistance: No single person can unilaterally decide to forbid certain persons from using the network.

To achieve this, blockchains work through a combination of cryptography and economic incentives: Cryptography limits what actors in the system can do (for example, transactions must be validly signed to be included in the chain) and economic incentives encourage actors to voluntarily perform actions that maintain the network's capabilities when spending their own resources (for example, miners or stakers actively publish new blocks to the chain because they can receive fees and new tokens as a reward). 

Starknet achieves secure low-cost transactions by using the STARK cryptographic proof system to reduce the size of transaction data while preserving and verifying the integrity of that data. To achieve resilience and censorship resistance, Starknet uses the STRK token to incentivize network participants to sequence transactions for users of the network and to ensure that there is a provably fair proof-of-stake mechanism to determine who should sequence and submit a proof for the network blocks.

== Purposes

* *Transaction fees:* Originally, fees in Starknet were paid only in Ether (ETH). As of v.0.13.0, fees for transactions on the network can be paid using STRK, as well as ETH.
+
A portion of the fees paid in STRK are converted to ETH by the receiving sequencer, in order to cover Ethereum L1 gas costs, which, due to the specifications of the Ethereum protocol, must be paid in ETH.

* *Staking:* Certain services that are critical to the liveness and security of Starknet may require the staking of Starknet tokens. These services might be offered by multiple providers, and could include sequencing, reaching temporary L2 consensus before L1 finality is reached, STARK-proving services, and data availability provisioning, to name a few examples. These https://starkware.co/resource/starknet-decentralization-a-roadmap-in-broad-strokes/[protocol changes] are still under discussion within the larger governance community and are targeted for https://starkware.co/resource/starknet-decentralization-a-roadmap-in-broad-strokes/[2024 -2025].

* *Governance:* Proposals for improving Starknet might require a minimal token support threshold. Voting, either directly or via delegation, will be required for changes to the protocol that are essential to Starknet's liveness, security, and maintenance. Today, for example, major updates to the Starknet Operating System require the approval of token holders.
For more information about Governance see the https://governance.starknet.io/[Starknet Governance Hub]

[IMPORTANT]
====
As discussed above, the Starknet tokens are digital assets intended to support the operation and usage of Starknet and are not offered as an investment. As such, the Starknet tokens do not represent any equity in StarkWare or the Starknet Foundation, nor do they provide any participation right in StarkWare or grant any right of claim from StarkWare or the Starknet Foundation.
====

== Supply and distribution

Ten billion Starknet tokens were initially created by StarkWare in May 2022 and minted onchain on November 30, 2022.

The existing ten billion tokens have been or are planned to be distributed according to the following:

[cols="1,2",]
|===
// |Percentage of total| Recipients | Details

|*20.04%: Early Contributors* |Tokens allocated for StarkWare's team members and early contributors. These tokens are subject to a lock-up schedule, as further detailed below.
|*18.17%: Investors* |Tokens allocated for StarkWare's investors. These tokens are subject to a lock-up schedule, as further detailed below.
|*10.76%: StarkWare* |Tokens allocated for StarkWare for operation services such as to pay fees, provide other services on Starknet, and engage other service providers.
|*12.93%: Grants including Development Partners (aka DPs)* |Tokens allocated for grants for research or work done to develop, test, deploy and maintain the Starknet protocol. The process for applications and allocations related to Starknet Foundation Grants will be outlined in a post at a later date.
|*9.00%: Community Provisions* |Tokens distributed to those who contributed to Starknet and powered or developed its underlying technology.
|*9.00%: Community Rebates* |Tokens allocated for rebates in Starknet tokens to partially cover the costs of onboarding to Starknet from Ethereum. Community rebates are not yet available and will be announced in 2024 in a subsequent post.
|*10.00%: Foundation Strategic Reserves* |Tokens allocated for the Starknet Foundation to fund ecosystem activities that are aligned with the https://www.starknet.io/en/content/introducing-the-starknet-foundation[Foundation's mission].
|*8.10%: Foundation Treasury* |Token allocated for the Starknet Foundation's treasury available for operations and other future initiatives by the Starknet Foundation.
|*2.00%: Donations* |Tokens reserved for donations to institutions and organizations, such as universities, NGOs, etc, as decided by the Starknet Foundation.
|===

image:planned_distribution_STRK.jpg[Planned distribution of STRK]

To align long-term incentives of the Investors and Early Contributors with the interests of the Starknet community, and following common practice in decentralized ecosystems, all tokens allocated to Investors and Early Contributors is subject to the following lock-up schedule, where percentages are based on the total token supply:

* Up to 0.64% (64 million tokens) will be unlocked on the 15th of each month, starting April 15, 2024, and going through March 15, 2025, for a total of 7.68% (768 million tokens) unlocked by March 15, 2025. +

* Up to 1.27% (127 million tokens) will be unlocked on the 15th of each month, starting April 15, 2025, and going through March 15, 2027, for a total of 30.48% (3.048 billion tokens) unlocked by March 15, 2027.

image::STRK_estimated_circulating_supply.jpg[Estimated supply of STRK in circulation]

[NOTE]
====
The above graph excludes newly circulating tokens resulting from inflation or staking (see below).

Token allotments currently retained by the Starknet Foundation, while contractually unlocked, are not considered circulating unless granted, donated, or otherwise allocated out of originating wallets through future grants, provisions, donations, developer initiatives, or other programs.
====

Through this lock-up period, token holders cannot transfer, sell, or pledge their STRK tokens. Delegation of voting is permitted with locked tokens and, when available, staking might also be permitted.

The total circulating supply of tokens is planned to increase over time with the minting of new tokens by the protocol, as staking rewards, block rewards, or other rewards associated with the staking process. Such minting will be made pursuant to a schedule that will be determined with the community at a later point, not before Starknet services are more decentralized. The supply in circulation might not, therefore, remain fixed. However, as long as StarkWare is the sole operator of the Starknet sequencer, there will be no issuance of new tokens for the purpose of block rewards. For more information, see https://starkware.co/resource/a-token-minting-proposal-to-manage-inflation/[_A token-minting proposal to manage inflation_^].

== Risks and disclaimers

Starknet is a developing decentralized protocol and the economic mechanisms described herein are subject to change based on decisions made by the larger community of Starknet builders and users. Starknet relies upon third parties to adopt and implement software and protocols as users and contributors of Starknet. It also relies, in whole or partly, on third parties to develop, supply and otherwise support it. There is no assurance or guarantee that such third parties will continue to participate in the network or that the network will continue to function as intended.

The technical documents provided herein describe certain planned and specified economic fundamentals of a digital asset, STRK. These materials are intended for informational purposes only and are meant to outline the usage and functionalities of the asset within Starknet. It is important to understand that the primary purpose of STRK is to pay for fees, provide a mechanism for securing consensus, and allow for decentralized governance on Starknet; it is not intended to serve as an investment.

Starknet relies upon third parties to adopt and implement the software and protocols as users of Starknet. It also relies, in whole or partly, on third parties to develop, supply and otherwise support it. As a Layer 2 network over Ethereum, Starknet also relies upon third parties maintaining and operating the Ethereum network. There is no assurance or guarantee that those third parties will complete their work, properly carry out their obligations, and/or otherwise meet anyone's needs.

STRK, as the native token of Starknet, may be subject to the risks of the Starknet network, including, without limitation, the following: (i) the technology associated with Starknet may not function as intended; (ii) the details of the Starknet token economics including the total supply and distribution schedule may be changed due to decisions made by the consensus of participants of the Starknet network; (iii) Starknet may fail to attract sufficient interest from key stakeholders or users; (iv) Starknet may not progress satisfactorily and Starknet tokens may not be useful or valuable; (v) Starknet may suffer from attacks by hackers or other individuals; and (vi) Starknet is comprised of open-source technologies that depend on a network of computers to run certain software programs to process transactions, and because of this model StarkWare and the Starknet Foundation have limited control over Starknet. 

Risks related to blockchain technology in general and Starknet in particular may impact the usefulness of Starknet, and, in turn, the utility or value of STRK. The software and hardware, technology and technical concepts and theories applicable to Starknet and STRK are still in an early development stage and unproven, there is no warranty that Starknet will achieve any specific level of functionality or success, nor that the underlying technology will be uninterrupted or error-free, and there is an inherent risk that the technology could contain weaknesses, vulnerabilities or bugs causing, potentially, the complete loss of any Starknet tokens held by Starknet users.

As with most commonly used public blockchains, STRK is accessed using a private key that corresponds to the address at which they are stored. If the private key, or the "seed" used to create the address and corresponding private key are lost or stolen, the tokens associated with that address might be unrecoverable and will be permanently lost. 

Public blockchain-based systems, including Starknet and the underlying Ethereum network, depend on independent verifiers, and therefore may be vulnerable to consensus attacks including, but not limited to, double-spend attacks, majority voting power attacks, race condition attacks, and censorship attacks. These attacks, if successful, could result in the permanent loss of STRK.

Starknet, STRK, and blockchain technology are nascent, and there may be additional risks not described above or that may be new or unanticipated. We recommend only using Starknet or holding STRK if you are familiar with the technology and aware of the risks.

This document and its contents are not, and should not be construed as, an offer to sell, or the solicitation of an offer to buy, any tokens, nor should it or any part of it form the basis or be relied on in connection with any contract or commitment whatsoever. This document is not advice of any kind, including legal, investment, financial, tax, or any other professional advice. Nothing in this document should be read or interpreted as a guarantee or promise of how the Starknet network or its STRK will develop, be utilized, or accrue value.

All information in this document is provided on an “as is” basis without any representation or warranty of any kind. This document only outlines current plans, which could change at the discretion of various parties, and the success of which will depend on many factors outside of Starknet Foundation's control. Such future statements necessarily involve known and unknown risks, which may cause actual performance and results in future periods to differ materially from what we have described or implied in this document. StarkWare and the Starknet Foundation disclaim all warranties, express or implied, to the fullest extent permitted by law with respect to the functionality of Starknet and STRK.



================================================
FILE: modules/architecture/pages/transactions.adoc
================================================
= Transactions

== Overview
Transactions are cryptographically signed instructions from accounts that update the state of the Starknet network. Starknet supports only xref:transaction_types[three types] of transactions, with each type going through the same xref:transaction_lifecycle[lifecycle] to receive its xref:transaction_statuses[execution and finality statuses]. Every transaction that was executed successfully is issued a xref:transaction_receipt[receipt], which includes its statuses, as well as other information about it.

.Additional information

* xref:resources:transactions-reference.adoc[] in _Resources_
* https://github.com/starkware-libs/starknet-specs/blob/master/api/starknet_api_openrpc.json[`starknet_api_openrpc.json`^] in the `starknet-specs` GitHub repository

== Transaction types
Starknet supports the following types of transactions:

[horizontal,labelwidth="20"]
`DECLARE`:: Introduces a new contract class to Starknet, enabling other contracts to either deploy instances of it or use it via a library call
+
[TIP]
====
For more information about contract classes and instances, see the https://book.cairo-lang.org/ch100-01-contracts-classes-and-instances.html[Cairo Book].
====

`INVOKE`:: Invokes a function in an existing contract instance, undergoing validation and execution initiated by the caller account's xref:accounts.adoc#starknets_account_structure[`+__validate__+` and `+__execute__+` functions] (respectively).
+
[NOTE]
====
The validation stage verifies that the caller account approves the transaction. Because an account's `+__validate__+` and `+__execute__+` functions can contain any logic, the caller account ultimately determines how to handle the `INVOKE` transaction.
====

`DEPLOY_ACCOUNT`:: Deploys a new account contract to Starknet.
+
[TIP]
====
For more information about deploying a new account, see xref:accounts.adoc#deploying_a_new_account[Accounts].
====

[NOTE]
====
The xref:messaging.adoc#l1_handler_transaction[`L1HandlerTransaction` type] is also a valid transaction type within Starknet, be it cannot be broadcast through the Starknet API like other transaction types, as it was specifically designed for internal Starknet operations (particularly, handling messages from L1 to L2).

The `DEPLOY` transaction type existed in Starknet for deploying account before being replaced by `DEPLOY_ACCOUNT`. `DEPLOY` only had one version (v0) and is now unsupported by Starknet. 
====

Each transaction type is versioned, with versions increasing when the fields that comprise the transaction change, either with the addition of a new field or the removal of an existing field. The following table summarizes the current, deprecated, and unsupported versions of each transaction type:

[cols=",,,"]
|===
| Type | Current version | Deprecated versions | Unsupported versions

|`INVOKE`
| v3
| None
| v1, v0

|`DECLARE`
| v3
| None
| v2, v1, v0

|`DEPLOY_ACCOUNT`
| v3
| None
| v1
|===

[IMPORTANT]
====
Do not submit a transaction that uses an unsupported transaction type, as it cannot be included in a proof, and therefore cannot become part of a Starknet block.

Sending transaction that use deprecated versions is still supported, but support will be removed in an upcoming Starknet release.
====

== Transaction lifecycle
The high-level steps in the Starknet transaction lifecycle are as follows:

. *Transaction submission:* A transaction is submitted to a sequencer by a full node.

. *Mempool validation:*
The sequencer's xref:transaction_mempool[mempool] performs preliminary validation of the transaction, such as ensuring that its invoker's balance exceeds the transaction's `max_fee` value, assuring the transaction's calldata length is within the legal limit, and more. If the transaction is invalid, it does not proceed.
// +
// [NOTE]
// ====
// Mempool validation in this context is analogous to Ethereum's signature checking, and includes running the account's `+__validate__+` function for an `INVOKE` transaction, `+__validate_declare__+` for a `DECLARE` transaction, or `+__validate_deploy__+` for a `DEPLOY_ACCOUNT` transaction.
// ====
. *Sequencer validation:* The sequencer performs preliminary validation of the transaction before executing it to ensure that the transaction is still valid. If the transaction is invalid, it does not proceed.
+
// [NOTE]
// ====
// The sequencer repeats the same validation performed by the mempool.
// ====

. *Execution:* The sequencer batches all transactions that passed the preliminary validation into a block, and applies them to the state sequentially. If a transaction fails during execution, it is included in the block with as reverted.

. *Proof generation and verification:* The prover uses the xref:os.adoc[Starknet operating system] to computes the proof for the correct execution of all transactions in the block, and transmits it to the L1 verifier, which verifies it. At this point, the L1 state is updated to include the transaction.

=== Mempools

Up to and including Starknet v0.13.5, transactions were received and ordered by the sequencer in a first-in-first-out (FIFO) fashion. Starting from Starknet v0.14.0, each sequencer will instead maintain a mempool, decouping the transaction order of arrival from the transaction ordering in blocks, for which they are can decide their own policy.

The introduction of mempools will have the following implications on how transactions are processed:

* *Nonces*: Transactions with a nonce greater than the sender's current nonce + stem:[x] will be rejected by the mempool, where:
** A sender's current nonce is the sender's nonce in the latest finalized state at the time the transaction is received
** stem:[50 \leq x \leq 100] is still TBD for `INVOKE` and `DEPLOY_ACCOUNT` transactions and stem:[x = 0] for `DECLARE` transactions (i.e., no declares with future nonces)

* *Fee escalation*: A transaction in the mempool can be replaced by a transaction sent from the same account with the same nonce and both `tip` and `max_l2_gas_price` increased by at least 10%
+
[NOTE]
====
There are unlikely edge cases in which a transaction is not replaced despite submitting a valid transaction to replace it, such as the existing transaction entering a block while the new one is still processed in the gateway.
====

* *Transaction time-to-live (TTL)*: Transactions that cannot be included in a block and have exceeded their TTL, currently configured to be 5 mins, are periodically evicted from the mempool

* *`DECLARE` transactions time-to-mature (TTM)*: Before being inserted into the mempool, `DECLARE` transactions are sent to a "waiting room" until they exceed their TTM, where TTM < TTL but is still TBD. While in the "waiting room", `DECLARE` transactions can't be replaced, and transactions sent with the same nonce as a transaction in the "waiting room" by the same account are rejected
// +
// [NOTE]
// ====
// The motivation for the `DECLARE` transactions "waiting room" is to impede a DoS attack where a `DECLARE` transaction is submitted and its code is compiled, but is then reaplced by sending a transaction with the same nonce while it matures.
// ====

== Transaction statuses

A transaction's state is represented by the following _finality_ and _execution_ statuses:

[cols="1,2,4"]
|===
| Type | Status | Description

.5+.^| *Finality*

| `NOT_RECEIVED`
| The transaction is not yet known to the sequencer.

| `RECEIVED`
a|The transaction was received by the mempool. The transaction is now either executed successfully, rejected, or reverted.

| `REJECTED`
a| The transaction was received by the mempool but failed the validation by the sequencer. Such transactions are not included in a block.
[NOTE]
====
A rejected transaction is stored in the mempool. You cannot send another transaction with the same transaction hash.
====

| `ACCEPTED_ON_L2`
| The transaction was executed and included in a block.

| `ACCEPTED_ON_L1`
| The transaction was accepted on Ethereum.

.2+.^| *Execution*

| `REVERTED`
a| The transaction passed validation but failed during the execution by the sequencer, and is included in a block as reverted.
[NOTE]
====
Since the `DEPLOY_ACCOUNT` and `DECLARE` transactions don't have an execution phase, they cannot be reverted.
====

| `SUCCEEDED`
| The transaction was successfully executed by the sequencer and is included in a block.
|===

Starting from Starknet version 0.14.0, these statuses will change to the following:

[cols="1,2,4"]
|===
| Type | Status | Description

.6+.^| *Finality*

| `NOT_RECEIVED`
| The transaction is not yet known to any sequencer.

| `RECEIVED`
a| A full node has successfully submitted the transaction to a sequencer.
[NOTE]
====
As there is currently no P2P protocol between full nodes for updating on each other about received transactions, querying a different node than the one that submitted the transaction for its status will result in a `Transaction hash not found` error. 

Therefore, relying on `RECEIVED` statuses requires initiating sticky HTTP sessions with your full node provider.
====

| `PRE-CONFIRMED`
a| The transaction was written to the feeder gateway's storage by a sequencer.
[NOTE]
====
As the transaction hasn't been executed yet, no execution information is available and only the transaction hash is written to the feeder gateway's storage.
====

| `EXECUTED`
| The transaction was successfully executed by a sequencer and its receipt was written to the feeder gateway's storage.

| `ACCEPTED_ON_L2`
| The transaction was included in a block finalized by the consensus protocol.

| `ACCEPTED_ON_L1`
| The Starknet state on L1 moved to a block height which is greater than or equal to the height of the block containing the transaction.

.2+.^| *Execution*

| `REVERTED`
a| The transaction failed during execution by a sequencer, and was included in a block as reverted.
[NOTE]
====
Since the `DEPLOY_ACCOUNT` and `DECLARE` transactions don't have an execution phase, they cannot be reverted.
====

| `SUCCEEDED`
| The transaction was successfully executed by a sequencer and is included in a block.
|===

=== State implications of reverted transactions

When a transaction is marked as `REVERTED`, the following state implications occur:

[horizontal,labelwidth="20"]
Nonce increases:: The nonce value for the account of the failed transaction iterates despite the failure.

Fee charge:: The sequencer charges a fee for the execution of the transaction up to the point of failure, and a respective `Transfer` event is emitted.

Partial reversion:: All changes that occurred during the validation stage are not reverted. However, all changes that occurred during the execution stage are reverted, including all messages to L1 or any events that were emitted during this stage. Events might still be emitted from the validation stage or the fee charge stage.

Fee calculation:: The fee charged for `REVERTED` transactions is the smaller of the following two values:

* The maximum fee that the user is willing to pay, either `max_fee` (pre-v3 transactions) or stem:[\text{max_amount} \cdot \text{max_price_per_unit}] (v3 transactions).
* The total consumed resources. 
+
[NOTE]
====
Consumed resources are resources used for the execution of the transaction up to the point of failure, including Cairo steps, builtins, syscalls, L1 messages, events, and state diffs during the validation and execution stages.
====

== Transaction receipt
A transaction receipt can be obtained by using the Starknet API's `starknet_getTransactionReceipt` endpoint and contains the following fields:

[horizontal,labelwidth="25"]
`transaction_hash`:: The hash of the transaction.
`actual_fee`:: The actual fee paid for the transaction.
`finality_status`:: The finality status of the transaction.
`execution_status`:: The execution status of the transaction.
`block_hash`:: The hash of the block that includes the transaction
`block_number`:: The sequential number of the block that includes the transaction
`messages_sent`:: A list of messages sent to L1.
`events`:: The events emitted.
`execution_resource`:: A summary of the execution resources used by the transaction.
`type`:: The type of the transaction.

The following is an example of a transaction receipt:

[source,json]
----
{
  "jsonrpc": "2.0",
  "result": {
    "actual_fee": "0x221db5dbf6db",
    "block_hash": "0x301fc0d09c5810600af7bb9610be10596ad6f4e6d28a60d397dd148f0962a88",
    "block_number": 906096,
    "events": [
      {
        "data": [
          "0x181de8b0cd32999a5cc962c5f724bc0f6a322f02957b80e1d5fef49a87588b7",
          "0x0",
          "0x9184e72a000",
          "0x0"
        ],
        "from_address": "0x49d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7",
        "keys": [
          "0x99cd8bde557814842a3121e8ddfd433a539b8c9f14bf31ebf108d12e6196e9"
        ]
      },
      {
        "data": [
          "0x764da020183e28a48ee38a9474f84e7e5ff13194",
          "0x9184e72a000",
          "0x0",
          "0x181de8b0cd32999a5cc962c5f724bc0f6a322f02957b80e1d5fef49a87588b7"
        ],
        "from_address": "0x73314940630fd6dcda0d772d4c972c4e0a9946bef9dabf4ef84eda8ef542b82",
        "keys": [
          "0x194fc63c49b0f07c8e7a78476844837255213824bd6cb81e0ccfb949921aad1"
        ]
      },
      {
        "data": [
          "0x181de8b0cd32999a5cc962c5f724bc0f6a322f02957b80e1d5fef49a87588b7",
          "0x1176a1bd84444c89232ec27754698e5d2e7e1a7f1539f12027f28b23ec9f3d8",
          "0x221db5dbf6db",
          "0x0"
        ],
        "from_address": "0x49d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7",
        "keys": [
          "0x99cd8bde557814842a3121e8ddfd433a539b8c9f14bf31ebf108d12e6196e9"
        ]
      }
    ],
    "execution_status": "SUCCEEDED",
    "finality_status": "ACCEPTED_ON_L2",
    "messages_sent": [
      {
        "from_address": "0x73314940630fd6dcda0d772d4c972c4e0a9946bef9dabf4ef84eda8ef542b82",
        "payload": [
          "0x0",
          "0x764da020183e28a48ee38a9474f84e7e5ff13194",
          "0x9184e72a000",
          "0x0"
        ],
        "to_address": "0xc3511006c04ef1d78af4c8e0e74ec18a6e64ff9e"
      }
    ],
    "transaction_hash": "0xdeadbeef",
    "type": "INVOKE"
  },
  "id": 1
}
----



================================================
FILE: modules/archive/pages/glossary.adoc
================================================
[id="glossary"]
= Glossary
:Cairo_header: pass:quotes[_Cairo programming language term_]

[#account-abstraction]
== account abstraction

Refers to the capability of users to define their own account logic instead of it being dictated by the protocol.

[#account_contract]
== account contract

An L2 smart contract, with programmable logic, that implements a user account on Starknet. An account contract implements special methods that enable initiating transactions.

.See also

* xref:#account-abstraction[account abstraction]

[#api]
== API

The Starknet Node API uses the Remote Procedure Call (RPC) architectural style, written in JSON format. For complete information on the Starknet Node API in JSON RPC format, see link:https://github.com/starkware-libs/starknet-specs/blob/master/api/starknet_api_openrpc.json[`starknet_api_openrpc.json`] on Github.

.See also

* xref:#rpc[RPC]

[#block]
== block

An ordered set of Starknet transactions. Blocks are built by the sequencer.

A block has the following identifiers:

[horizontal,labelwidth="20"]
block hash:: A unique identifier that can be used to query and refer to the block.
block number:: A number representing the location of the block in the sequence of accepted blocks in Starknet.

[#builtin]
== builtin

An optimized low-level execution unit that is added to the Cairo CPU board to perform predefined computations that are expensive to perform in standard Cairo, including range-checks, Pedersen hash calculations, and ECDSA.

[#cairo-step]
== Cairo step

The smallest unit of execution within the Cairo VM, typically involving mathematical, logical, or control-flow operations that collectively define the behavior of a program.

[#cairovm]
== Cairo VM

The Cairo Virtual Machine (VM) is software that knows how to execute compiled Cairo byte-code. The result of this execution is the program trace that can then be sent to a STARK prover in order to prove the validity of the instruction expressed in the Cairo code.

[#contract_class]
== contract class

The definition of a contract. It includes Cairo byte code, entry point names, and everything that defines its semantics.

[#contract_instance]
== contract instance

A deployed contract that corresponds to a class. Only contract instances act as true contracts, in that they have their own storage and can be called by transactions or other contracts.

[#fri]
== fri

The smallest denomination of STRK. 1 fri = 10^-18^ STRK.

[#full-node]
== full node

A machine that runs the Starknet execution protocol. A full node stays synchronized with the latest state of the network, stores past blocks and transactions, and enables users to interact with the network, such as by querying its state or by broadcasting new transactions.

[#l1]
== Layer 1, L1

The base layer of a blockchain network, such as Ethereum, where transactions are directly recorded and validated. It includes the underlying protocol and consensus mechanism that establish the foundational rules for the blockchain.

[#l2]
== Layer 2, L2

Exists on top of an L1 blockchain, such as Ethereum, in order to add value to the L1, by providing features such as massive computation scale without compromising on Ethereum’s composability and security.

// [#l3]
// == Layer 3, L3

// Built on top of an L2 solution, providing further enhancements or specialized functionalities.


[#multicall]
== multicall

A single transaction that executes multiple bundled transactions, which are signed once on Starknet. If one call fails, the entire operation is aborted.

[#prover]
== prover

The entity that receives the output of Cairo programs and generates proofs to be verified. In the context of Starknet, the prover generates proofs of the computational integrity of the work performed by the sequencer. It then submits the proof to the verifier on L1, which registers the fact.

.See also

* xref:#SHARP[SHARP]
* xref:#verifier[verifier]

[#rpc]
== RPC

The Starknet RPC API provides clients an interface to retrieve information on the state of the chain and to interact with it, such as by posting transactions or estimating the fee of a transaction before it is sent.

.See also

* xref:#api[API]

[#sequencer]
== sequencer

A set of services that together receive transactions from the network, put them in order, check their validity, and build blocks.

[#SHARP]
== SHARP

The Shared Prover (SHARP) is a mechanism used in Starknet that aggregates multiple Cairo programs from different users, each containing different logic. These Cairo programs are then executed together, generating a single proof common to all the programs.


[#sierra]
== Sierra

An intermediate representation between Cairo and Casm. Sierra code is then compiled into a Casm program with the property that, for any input, the program's execution is provable. In particular, it ensures that the execution of a transaction is provable regardless of whether the execution succeeded or was reverted due to an error.

.Additional resources

* link:https://docs.starknet.io/architecture/smart-contracts/cairo-and-sierra/[Cairo and Sierra]

[#stark]
== STARK

A proof system that uses cryptography to provide polylogarithmic verification resources and proof size, with minimal and post-quantum-secure assumptions.

[#starknet-l1-core-contract]
== Starknet L1 Core Contract

A smart contract deployed on Ethereum. Its address is link:https://etherscan.io/address/0xc662c410c0ecf747543f5ba90660f6abebd9c8c4[`0xc662c410c0ecf747543f5ba90660f6abebd9c8c4`]. It defines the state of Starknet
 by storing:

* The commitment to the L2 state.
* The Starknet OS program hash – effectively defines the version of Starknet the network is running.

The committed state on the L1 Core Contract acts as the consensus mechanism of Starknet, that is, the system is secured by the L1 Ethereum consensus. In addition to maintaining the state, the Starknet L1 Core Contract is the main hub of operations for Starknet on L1. Specifically:

* It stores the list of allowed verifier contracts that can verify state update transactions
* It deals with cross-layer interaction between L1 and L2.

[#starknet]
== Starknet

A permissionless Validity-Rollup, also known as a zero-knowledge rollup (ZK rollup) for Ethereum. Starknet is a Layer 2 (L2) blockchain, enabling any dApp to achieve massive computation scale without compromising Ethereum’s composability and security.

Starknet aims to achieve secure, low-cost transactions and high performance by using the STARK cryptographic proof system. Starknet contracts and the Starknet OS are written in Cairo, a custom-built and specialized programming language.

[#starknet-os]
== Starknet OS

The Cairo program that, upon receiving a set of transaction as input, executes the state transition. For more information, see xref:architecture:state/[Starknet state]. The integrity of this computation is what is actually proven and verified.


[#starknet-state]
== Starknet state

The set of all the contracts' code and all the memory slots and their values, in every contract's storage.

.See also

* xref:architecture:state/[Starknet state]

[#transaction]
== transaction

A transaction can be seen as a message containing a set of instructions that describe a state transition. The Starknet protocol has the following types of transactions, which affect different parts of the state:

* `DECLARE`
* `INVOKE`
* `DEPLOY_ACCOUNT`

.See also

* xref:architecture:transactions.adoc#transaction_types[Transaction types]
* xref:architecture:state.adoc[Starknet state]

[#statediff]
== state diff

The data describing the difference between two states. It contains information on every contract whose storage was updated and additional information on contract deployments.

[#trace-cells]
== trace cell

A unit of measurement of proving complexity. In the STARK protocol, a computation is translated into an execution trace that must satisfy a collection of constraints. Every Cairo step translates to ~50 trace cells.

[#verifier]
== verifier

A set of L1 smart contracts whose purpose is to verify STARK proofs submitted by the Shared Prover (SHARP).


================================================
FILE: modules/archive/pages/nodes.adoc
================================================
[#nodes]
= Nodes

This topic explores the role and functionality of nodes in the Starknet ecosystem, their interactions with sequencers, and their overall importance.

[#overview-of-nodes-in-the-starknet-ecosystem]
== Overview of nodes in the Starknet ecosystem

A node in the Starknet ecosystem is a computer equipped with Starknet software, contributing significantly to the network's operation. Nodes are vital for the Starknet ecosystem's functionality, security, and overall health. Without nodes, the Starknet network would not be able to function effectively.

Nodes in Starknet are categorized into two types:

* *Full nodes*: Store the entire Starknet state and validate all transactions, crucial for the network's integrity.
* *Light nodes*: Do not store the entire Starknet state but rely on full nodes for information. Light nodes are faster and more efficient but offer less security than full nodes.

[#core-functions-of-nodes]
=== Core functions of nodes

Nodes are fundamental to the Starknet network, performing a variety of critical functions:

* *Transaction validation*: Nodes ensure transactions comply with Starknet's rules, helping prevent fraud and malicious activities.
* *Block Creation and Propagation*: Nodes create and circulate blocks to maintain a consistent blockchain view across the network.
* *State maintenance*: Nodes track the Starknet network's current state, including user balances and smart contract code, essential for transaction processing and smart contract execution.
* *API endpoint provision*: Nodes provide API endpoints, aiding developers in creating applications, wallets, and tools for network interaction.
* *Transaction relay*: Nodes relay user transactions to other nodes, improving network performance and reducing congestion.

[#interplay-of-nodes-sequencers-clients-and-mempool-in-the-starknet-network]
== Interplay of nodes, sequencers, clients, and the mempool in Starknet

[#nodes-and-sequencers]
=== Nodes and sequencers

Nodes and sequencers are interdependent:

* *Nodes and block production*: Nodes depend on sequencers to create blocks and update the network state. Sequencers integrate the transactions validated by nodes into blocks, maintaining a consistent and current Starknet state.
* *Sequencers and transaction validation*: Sequencers rely on nodes for transaction validation and network consensus. Prior to executing transactions, sequencers work with nodes to confirm transaction legitimacy, deterring fraudulent activities. Nodes also contribute to the consensus mechanism, ensuring uniformity in the blockchain state.

[#nodes-and-clients]
=== Nodes and clients

The relationship between nodes and clients in the Starknet ecosystem is characterized by a client-server model:

* *Client requests and node responses*: Clients send requests, like transaction submissions or state queries. Nodes process these requests, validating transactions, updating the network state, and providing clients with the requested data.
* *Client experience*: Clients receive node responses, updating their local view with the latest network information. This loop enables user interaction with Starknet DApps, with nodes maintaining network integrity, while clients provide a user-friendly interface.

[#nodes-and-the-mempool]
=== Nodes and the mempool

The mempool acts as a holding area for unprocessed transactions:

* *Transaction validation and mempool storage*: Upon receiving a transaction, a node validates it. Valid transactions are added to the mempool and broadcast to other network nodes.
* *Transaction selection and block inclusion*: Nodes select transactions from the mempool for processing, incorporating them into blocks that are added to the blockchain.

[#node-implementations-in-starknet]
== Node implementations in Starknet

Each Starknet node implementation has its own strengths:

* https://github.com/eqlabs/pathfinder[*Pathfinder*], by Equilibrium: Pathfinder is a full node written in Rust. Pathfinder excels in high performance, scalability, and aligns with the Starknet Cairo specification.
* https://github.com/NethermindEth/juno[*Juno*], by Nethermind: Juno, is a  full node written in Golang. Juno is known for user-friendliness, ease of deployment, and compatibility with Ethereum tools.
* https://github.com/starkware-libs/papyrus[*Papyrus*], by StarkWare: Papyrus is also a full node written in Rust. Papyrus focuses on security and robustness. It's integral to the upcoming Starknet Sequencer, expected to boost network throughput.

These implementations are continuously being improved, with new features and enhancements. The choice of implementation depends on user or developer preferences and requirements.

Key characteristics of each node implementation are summarized below:

|===
|Node Implementation |Language |Strengths

|Pathfinder |Rust |High performance, scalability, Cairo specification adherence
|Papyrus |Rust |Security, robustness, Starknet Sequencer foundation
|Juno |Golang |User-friendliness, ease of deployment, Ethereum compatibility
|===



================================================
FILE: modules/archive/pages/cairo-101/arrays.adoc
================================================
= Arrays

An array is a growable collection of objects of the same type, stored in contiguous memory.

An empty array of type `T` can be initialized using `ArrayTrait::<u128>::new()`. The `array!` macro can be used create arrays with values that are already known at compile time.

Elements in an array can be accessed using the `at()` method and `arr[index]` subscripting operator.

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let mut arr = ArrayTrait::<u8>::new()
    assert!(arr.is_empty());
    arr.append(2);
    arr.append(3);
    let mut arr: Array<u8> = array![1, 2, 3];
    let front = arr.pop_front().unwrap();
    assert!(front == 1);
    assert!(arr.len() == 2);
    assert!(*arr.at(0) == 2);
    assert!(*arr[1] == 3);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQMwdgBAtghglmAFASggbwDqQjgNgUwBdoBXYmAJwoC4IBBKmATwB4SAOAPggF4JKKzAIQBtAIwAaCACYAugG4sOHAIB0MAA4b8YACaIAzMkXY8RCCAoB7MMT5qNVjQH1LNwilUkwAd0EaUE2V+AGcQ-ApCIUQ3W14+MWMlZRgwiKjENQIkVB4+aSTTUPDI6IAqNRgPAAZc-MLg1JKMiqpxWXiIIxMAX2AgA
:cairo-book-link: https://book.cairo-lang.org/ch03-01-arrays.html
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about variables in {cairo-book-link}[the Cairo Book^].
====


================================================
FILE: modules/archive/pages/cairo-101/booleans.adoc
================================================
= Booleans

The boolean type in Cairo is specified using `bool`, and has two possible values: `true` and `false`.

Using integer literals for `bool` declarations is not allowed.


[discrete]
=== Example

[source,cairo]
----
fn main() {
    // let t: bool = 1  <-- fails to compile
    let t = true; // bool type inferred from context annotation
    assert!(t);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQAhDMDsQWwQwJaQBQEoQG8A60wgPT4gA2ApgC4jkBcIARgPYPEgC8IAjGADwC0vERMQDOVBiADGDGAAcEZHHhIUqbKgCcArqQDcBIo2ZUAnjNIgk4UuvWkAJhHXTJDSOVIAPSnEiQG5OHIEV0U8OGFha3IAQmRyVB0cAF9gIA
:cairo-book-link: https://book.cairo-lang.org/ch02-02-data-types.html#the-boolean-type
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about booleans in {cairo-book-link}[the Cairo Book^].
====



================================================
FILE: modules/archive/pages/cairo-101/constants.adoc
================================================
= Constants

Constants store data that cannot be modified, just like immutable variables. However, unlike immutable variables:

* Constants are declared using the `const` keyword
* Constants do not allow using the `mut` keyword (i.e., constant are not only immutable by default, but are _always_ immutable)
* Constants require explicit type annotation
* Constants must be set to a constant expressions (and not the result of a value that can only be computed at runtime)

Moreover:

* Constants can be declared in the global scope
* Constants use the `SCREAMING_SNAKE_CASE` form by convention

[discrete]
=== Example

[source,cairo]
----
// const mut ONE_HOUR_IN_SECONDS = 60*60; <-- fails to compile
const ONE_HOUR_IN_SECONDS: u32 = 3600;

fn main() {
    assert!(ONE_HOUR_IN_SECONDS == 60*60);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQehAIGMHsDsGcAu4C2BXZB5AcgUQPoASmAqgEr4CS2+AyrgMI4Ait4AvOAGwAMAVLwDc4ADwBaMeABmAQwCWAG3CJoUaCgAOigKYAdWDARY8RUhWp1GLWgC5waAMwAmDuAe8eg-fqmxU82AAKAEpwAG99cCjwGXh4bQAnRABCQJwCYnIqGnombFYOTl4BHmCvWABfYCA
:cairo-book-link: https://book.cairo-lang.org/ch02-01-variables-and-mutability.html#constants
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about constants in {cairo-book-link}[the Cairo Book^].
====


================================================
FILE: modules/archive/pages/cairo-101/data-types.adoc
================================================
= Data Types

== Introduction 

[source,cairo]
----
fn main() {
    // Every value in Cairo is of a certain data type,
    // which is determined by its annotation:
    let type_from_annotation: felt252 = 3;

    // or context:
    let mut type_from_context = type_from_annotation;

    // Types cannot be muted, so the following will produce an error:
    // type_from_context = true;
}
----

== `felt252`

[source,cairo]
----
fn main() {
    // The default data type in Cairo is `felt252`:
    let a_felt = 0;

    // Felts are integers that must be lower than or equal to
    // P = 3618502788666131213697322783095070105623107215331596699973092056135872020480:
    // and must be less than the P, so the following will produce an error:
    // let P = 3618502788666131213697322783095070105623107215331596699973092056135872020481

    // When adding, subtracting, or multiplying,
    // the result is computed mod P:
    println!("0 - 1 == {}", a_felt - 1);

    // division has to be done explicitly via the external felt252_div function,
    // which returns the expected result and if y divides x as integers:
    println!("{0}/{1} = {2}", 6, 2, felt252_div(6,2));

    // but more surprising results otherwise:
    println!("{0}/{1} = {2}", 1, 2, felt252_div(1,2));

}
----



================================================
FILE: modules/archive/pages/cairo-101/enums.adoc
================================================
= Enums

An enum in Cairo works like a tagged union, which can be accessd via pattern matching.

Traits can implemented for enums, allowing to define methods and behaviors associated with them.

*Example (click https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQAhDMDsQWwQwJaQBQEoQG8A60wgDYCmALiAjDAK7FwBGRA+gG5wBOAXCJQBwgC8IAIwB2ANwgA9BJCEAHgAd8CAMYJSxAJ7zCIOJEgB7GsQQHIOPJOnkqNeoWZt+IAMzdxIADwBabxET4AM4gxAYgygYw8ghEFnhEpLaw1HSMLKzONin2jqziUiFaOjxkkOCErKyEACYQrJHhZsRyxHFgtqkO6c5uojhtuoGBFcQAhMgdOd2jAll2aWyofZAAvsBAA[here^] to experiment with this code in the Cairo playground):*

[source,cairo]
----
fn main() {
    enum Message {
        Quit,
        Echo: felt252,
        Move: (u128, u128),
    }
    let m: Message = Message::Move(1,2);
    match m {
        Message::Move((x, y)) => { assert!(x != y) },
    }
}
----


================================================
FILE: modules/archive/pages/cairo-101/felt.adoc
================================================
= Felts

The basic data type in Cairo is `felt252`, which stands for field element of a 252-bit field. These are integers that range from `0` (inclusive) to `P` (exclusive), where `P` is a large prime number equal to:

stem:[2^{251} + 17\cdot2^{192} + 1 =]
stem:[3618502788666131213697322783095070105623107215331596699973092056135872020481]

Field elements have the property of intentionally wrapping around when their value falls outside of their range (i.e., they use `mod P` arithmetic). Division of field elements has to be done explicitly via the external `felt252_div`, which is *not* floor division. Instead, `felt252_div(a,b)` returns `c` such that `a = c * b (mod P)`.

`felt252` is the default data type for numerical literals, so in many cases there is no real need to specify the type of numerical variables.

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let P_minus_1 = 3618502788666131213697322783095070105623107215331596699973092056135872020480;
    let P_plus_1_halved = 1809251394333065606848661391547535052811553607665798349986546028067936010241;
    assert!(P_minus_1 + 1 == 0); // P = 0 (mod P)
    assert!(felt252_div(2, 1) == 2); // 2 = 2 * 1 (mod P)
    assert!(felt252_div(1, 2) == P_plus_1_halved); // 1 = (P+1)/2 * 2 (mod P)
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQAhDMDsQWwQwJaQBQEoQG8A60wgDYCmALiAAoD6MSArgM4UCMIAvCAMwBsjAHAKwAGAEwB2Hj06TG7RkOmcAnCPZDRPdgIWCRAxgL6chMgSLl92MvgskLbyzUP3d2fHqeECALDwEBuHHgEJOQUAA749EwUABZw+ABuhAAmrCC8DnzSCp4WGpwGApw83lLsCox8niLmgnxCPIwV5pwmknwiCuqethKVLfWFHVy6wp6M-rhgcHR0hABOxACEyJTUkJHMANRprGwCqL4gAPRH5KkCIMgwAPYpZKgBeNOzC8vghPjEQnUUSQjxyCEABo0ugWGwhAdjqchKlYQAqHZXW7kB6TEDPeZLZDvT7fIS-f7IRggyG7ELhDYxOKJJJQk47NgrTaMVBHBEgWHIu5ogC+wCAA
:cairo-book-link: https://book.cairo-lang.org/ch02-02-data-types.html#felt-type
[TIP]
====
You can experiment with the example in {cairovm-codes-link}[cairovm.codes^] and read more about felts in {cairo-book-link}[the Cairo Book^].
====



================================================
FILE: modules/archive/pages/cairo-101/functions.adoc
================================================
= Functions

Functions can be defined using the `fn` keyword, and use the `snake_case` form by convention.

Functions can a return value to the code that calls them by declaring its type after an arrow (->) and using the `return` keyword. The return value of a function is also synonymous with the value of the final expression in the block of the body of a function.

Named parameters allow specifying the names of parameters when calling a function. Passing a variable with the same name as the parameter allows for an even shorter syntax.

*Example (click https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQMwdgBAJgpgxgfQB4AokC4IFcDMAmASggFoA+bfCAbwB1IIGAnGAFy0ciRIgEYBuOgF86dcBACWYRKgwVCJcrjzU6DBlwDUvISLBiAtgENJKIrXoNDAZysxGLAIQpY0lABYiAXk8SpyFIQEAmCCwEA[here^] to experiment with this code in the Cairo playground):*
[source,cairo]
----
fn add_x_y(x: u32, y: u32) -> u32 {
    return x - 1;
}

fn sub_x_y(x: u32, y: u32) -> u32 {
    x - 1
}

fn main() {
    assert!(dec_x(4) == inc_x(2));
}
----


================================================
FILE: modules/archive/pages/cairo-101/if-expressions.adoc
================================================
= `if` expressions

An `if` expression is a control flow construct that allow us to conditionally execute a piece of code depending on the value of a boolean condition. Since it is an expression, it returns the value of the last expression in the branch.

You can combine several conditions using boolean operators like `&&` (and), `||` (or), etc. You can also add an optional `else` branch like in many other programming languages.

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let lang = 'Cairo';
    let version = '2.11.4';
    let updated = true;

    if lang == 'Cairo' && version == '2.11.4' {
        assert!(updated);
    } else {
        assert!(!updated)
    }
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQMwdgBAtghglmAFASggbwDqQjgNgUwBcJcYwBzCAXggHIBheAJwHtaBuLHPIiAN3xMAznBaQatAEwA6AIyzpAFg5duBYgFcADgBMYhfDuoRCTDfk5hVOOCBJlKVCYzitaEAGQf+gkWOoSMvJK7pjY3NwwQkKChACEiNp6BjrIlhEAvhD4uDHo1hEQUTFM8YhxSfqGyAUZWBnAQA
:cairo-book-link: https://book.cairo-lang.org/ch02-05-control-flow.html#if-expressions
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about `if` expressions in {cairo-book-link}[the Cairo Book^].
====


================================================
FILE: modules/archive/pages/cairo-101/integers.adoc
================================================
= Integers

It is highly recommended to use integer types where possible, as they come with extra protection against potential vulnerabilities in the code, such as overflow checks.

Integer types include `i8`, `i16`, `i32`, `i64`, and `i128` for signed integers and `u8`, `u16`, `u32`, `u64`, `u128`, and `u256` for unsigned integers, and may be annotated via a suffix.

Integer division is truncated down to the nearest integer. 

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let a: u64 = 56;  // Regular annotation
    let b = 32_u64; // Suffix annotation
    assert!(a / b == 1);
    assert!(b / a == 0);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQAhDMDsQWwQwJaQBQEoQG8A60wgDYCmALiHAFwgCuAbACwgC8IArDQNxgD0XIASoQDmVfHABOZSJAD2xOMQTTIOPARIgARkxABmAEwB9WnU48QAZSrhwCAB6SZchUpV44AZ3eExxAITI4EF4tRmYARlR2VzAPLx9-LV5A0JAABkicAF9gIA
:cairo-book-link: https://book.cairo-lang.org/ch02-02-data-types.html#integer-types
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about integers in {cairo-book-link}[the Cairo Book^].
====



================================================
FILE: modules/archive/pages/cairo-101/loops.adoc
================================================
= Loops

The `loop` keyword tells Cairo to loop and execute a block of code until you explicitly told to to stop.

The `while` keyword tells Cairo to loop and execute a block of code as long as a condition is met.

The `for` keyword tells Cairo to loop and execute a block of code over for each item in a collection.

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let mut res: u8 = 1;
    loop {
        if res == 5 {
            break;
        }
        res += 1;
    };
    assert!(res == 5);
    while res != 1 {
        res -= 1;
    };
    assert!(res == 1);
    for n in 1..5_u8 { // Range of 1 to 5
        assert!(res == n);
        res += 1;
    };
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQMwdgBAtghglmAFASggbwDqQjgNgUwBdoBXYgJ3wGcAuCEgDggF4IBGAbixzwHteADum49RcEBEpUWrAKzDsopRABGlGAGsuipQF8RyqRADUrTgYi7tomFSr5yhAISIjzOcms8A7gAs4BJLUEE5mCso4RgC0Zl44Vha29o4ubmaeFiC85BCQCOwAdAWyAPqM6BAA9JUQAEowYADm+BC8EmwQhLwQshY2dg7OrsHuuRk6okam7HGW2rrAQA
:cairo-book-link: https://book.cairo-lang.org/ch02-05-control-flow.html#repetition-with-loops
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about loops in {cairo-book-link}[the Cairo Book^].
====



================================================
FILE: modules/archive/pages/cairo-101/strings.adoc
================================================
= Strings

Cairo doesn't have a native type for strings but provides two ways to handle them: short strings using simple quotes and `ByteArray` using double quotes.

A short string is the concatenation of the ASCII encoding of its characters. Cairo uses `felt252` for short strings, and as such, short strings are limited to 31 characters (⌊251 / 8⌋ = 31). Short strings can be represented with an hexadecimal value or by directly writing the string using simple quotes.

Cairo's Core library provides a `ByteArray` type for handling strings and byte sequences longer than 31 characters. ByteArray strings are written using double quotes.

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let short_string = 'aa';
    assert!(short_string == 0x6161);
    let long_string: ByteArray = "this is a string which has more than 31 characters";
    assert!(long_string.len() > 31);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQAhDMDsQWwQwJaQBQEoQG8A60wgDYCmALiAM4AWA9gE7ED6ZxNSA5iALwgDkcc3Abhx4QcMmUJ0AhMkq0GTFpHYcuABgAeANgCMu1ENxgipfFWWNmbAFwgAQgE9ihAII0acB5xBZgxCghkIIGi5FbKIADuAQDGFCAUYrC0hCD+cNAAzDogcXAeMc40ZL6GImIS0shmFopsAHREKOgAfCDZBjgAvsBAA
:cairo-book-link: https://book.cairo-lang.org/ch02-02-data-types.html#string-types
[TIP]
====
You can experiment with the example in {cairovm-codes-link}[cairovm.codes^] and read more about strings in {cairo-book-link}[the Cairo Book^].
====



================================================
FILE: modules/archive/pages/cairo-101/structs.adoc
================================================
= Structs

Structs, which stands for "structures", can be created with the `struct` keyword using a classic C structs syntax. Variables named similar to a struct's members allow to use a shorter syntax, and struct update syntax allows to use fields of other structs.

Dot notation is used to get a specific value from a struct.

*Example (click https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQZwLgTgrgxmAEAFA9gSwHYIN4B13wPgA8AueKAZgCYAaPQ+ATzMtrwF888AzfAWwCGGABQBKeLnyEANgFMEABwCMZFBgQBeJGkwTiZAKw0mZAAzx2Abnoz5xeFqWnrUgnMVUH29XqLGAdP7KFi4MAiAgshBgAITCClT+RA6O5gBkafAJ-owp8KaiLuzAQA[here^] to experiment with this code in the Cairo playground):*

[source,cairo]
----
struct Point {
    x: u32,
    y: u32,
}

fn main() {
    let p1: Point = Point { x: 5, y: 0 };
    let x = 10;
    let p2 = Point { x, ..p1 };
    assert!(p2.x == 10 && p2.y == 0);
}
----


================================================
FILE: modules/archive/pages/cairo-101/tuples.adoc
================================================
= Tuples

A `tuple` in Cairo allows us to group multiple values with a variety of types into a single element with a fixed length that can't be changed after its declaration.

Tuples can be declared with or without specifying the type of each element in the tuple, and deconstructed during or after their declaration. 

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let tup: (felt252, bool) = (8, false);
    let (a, _) = tup; 
    let (b, _) = (8, false);
    assert!(a == b);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQMwdgBAtghglmAFASggbwDqQjgNgUwBcJCBXABwC4JER9dCAmAVkYBoIAjAe291QC8NABwcQMXAGd8yANxYceIjRgcA+oJIV52JcUSd1mxKIjipMnYogxJ0gE6EAhIhgQBQznKwBfYEA
:cairo-book-link: https://book.cairo-lang.org/ch02-02-data-types.html#the-tuple-type
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about tuples in {cairo-book-link}[the Cairo Book^].
====


================================================
FILE: modules/archive/pages/cairo-101/variables.adoc
================================================
= Variables

Data can be stored in variables using the `let` keyword.

Variables are immutable by default, but this can be overridden using the `mut` keyword.

Variables can be type annotated, but Cairo can also infer types from context.

[discrete]
=== Example

[source,cairo]
----
fn main() {
    let immutable_var: u8 = 17; // explicit type annotation
    // immutable_var = 38;  <-- fails to compile
    let mut mutable_var = immutable_var; // type u8 inferred from context
    mutable_var = 38;
    assert!(mutable_var != immutable_var);
}
----

:cairovm-codes-link: https://cairovm.codes/?codeType=Cairo&debugMode=Debug%20Sierra&code=EQAhDMDsQWwQwJaQBQEoQG8A60wgDYCmALiAjDAK7FwBGRA+gG5wBOAXCJQBwgC8IAIwB2ANwgA9BJCEAHgAd8CAMYJSxAJ7zCIOJEgB7GsQQHIOPJOnkqNeoWZt+IAMzdxIADwBabxET4AM4gxAYgygYw8ghEFnhEpLaw1HSMLKzONin2jqziUiFaOjxkkOCErKyEACYQrJHhZsRyxHFgtqkO6c5uojhtuoGBFcQAhMgdOd2jAll2aWyofZAAvsBAA
:cairo-book-link: https://book.cairo-lang.org/ch02-01-variables-and-mutability.html#constants
[TIP]
====
You can experiment with this example in {cairovm-codes-link}[cairovm.codes^] and read more about variables in {cairo-book-link}[the Cairo Book^].
====


================================================
FILE: modules/archive/pages/ecosystem/auditors-security-platforms.adoc
================================================
[id="audit_providers"]
= Auditors and security platforms

== Auditors
[%autowidth.stretch,cols=",",options="header"]
|===
| Provider
| URL

| ABDK
| https://www.abdk.consulting/[abdk.consulting^]

| Beosin
| https://beosin.com/[beosin.com^]

| Beyond
| https://beyondaudit.github.io/[beyondaudit.github.io^] 

| Cairo Security Clan
| https://cairosecurityclan.com/[cairosecurityclan.com^]

| ChainSecurity
| https://chainsecurity.com/[chainsecurity.com^]

| CODESPECT
| https://codespect.net/[codespect.net^]

| ConsenSys
| http://consensys.net/diligence[consensys.net/diligence^]

| Defense
| https://thesis.co/defense[thesis.co/defense^]

| Extropy
| https://www.extropy.io/[extropy.io^]

| FuzzingLabs
| https://fuzzinglabs.com/[fuzzinglabs.com^]

| Ginger Security
| https://gingersec.xyz/[gingersec.xyz^]

| Hashlock
| https://hashlock.com/[hashlock.com^]

| Nethermind Security
| https://www.nethermind.io/smart-contract-audits[nethermind.io/smart-contract-audits^]

| Oak Security
| https://www.oaksecurity.io/[oaksecurity.io^]

| Open Zeppelin
| https://www.openzeppelin.com/[openzeppelin.com^]

| OtterSec
| https://osec.io/[osec.io^]

| PeckShield
| https://peckshield.com/[peckshield.com^]

| Softstack
| https://softstack.io/[softstack.io^]

| Trail of Bits
| http://www.trailofbits.com/[trailofbits^]

| Zellic
| https://www.zellic.io/[zellic.io^]
|===

== Security platforms

[%autowidth.stretch,cols=",",options="header"]
|===
| Provider
| URL

| Hypernative
| https://www.hypernative.io/[hypernative.io^]

| Trustblock
| https://trustblock.run/[trustblock.run^]
|===



================================================
FILE: modules/archive/pages/ecosystem/block-explorers-monitoring-tools.adoc
================================================
= Block explorers and monitoring tools

== Block explorers

[%autowidth.stretch,cols=",,",options="header"]
|===
| Name
| URL (Mainnet)
| URL (Sepolia)

| Voyager
| https://voyager.online[voyager.online^]
| https://sepolia.voyager.online[sepolia.voyager.co^]

| Starkscan
| https://starkscan.co[starkscan.co^]
| https://sepolia.starkscan.co[sepolia.starkscan.co^]

| Cartridge
| https://explorer.cartridge.gg/[explorer.cartridge.gg^]
| N/A

| ViewBlock
| https://viewblock.io/starknet[viewblock.io/starknet^]
| N/A

| OKLink 
| https://www.oklink.com/starknet[oklink.com/starknet^]  
| N/A
|===

== Monitoring tools

[cols="1,2,3",options="header"]
|===
| Name
| URL
| Description

| Starknet Status
| https://status.starknet.io/[status.starknet.io^]
| Starknet status provides timely status information about the health of Starknet sequencing.

| Starknet Monitor
| https://www.starknet-monitor.com/[starknet-monitor.com^]
| Starknet Monitor shows vital statistics about Starknet and core infrastructure.

|=== 



================================================
FILE: modules/archive/pages/ecosystem/bridges-oracles.adoc
================================================
= Bridges and oracles 

== Bridges

[%autowidth.stretch,cols=",",options="header"]
|===
| Name
| URL

| ArkProject (NFT bridge)
| https://bridge.arkproject.dev/[bridge.arkproject.dev^]

| Layerswap
| https://layerswap.io/app[layerswap.io/app^]

| Mini Bridge
| https://minibridge.chaineye.tools/?src=ethereum&dst=starknet[minibridge.chaineye.tools^]

| Orbiter Finance
| https://www.orbiter.finance/en?src_chain=1&tgt_chain=SN_MAIN&src_token=ETH[orbiter.finance^]

| Owlto Finance
| https://owlto.finance/[owlto.finance^]

| Rango
| https://app.rango.exchange/bridge?fromBlockchain=ARBITRUM&fromToken=ETH&toBlockchain=STARKNET&toToken=ETH--0x49d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7[app.rango.exchange/bridge^]

| Rhino.fi
| https://app.rhino.fi/bridge?token=ETH&chainOut=STARKNET&chain=ETHEREUM[app.rhino.fi/bridge^]

| RetroBridge
| https://app.retrobridge.io/?tokenFrom=ETH[app.retrobridge.io^]

| StarkGate
| https://starkgate.starknet.io/bridge/deposit[starkgate.starknet.io^]
|===

== Oracles

[cols="1,1,3",options="header"]
|===
| Name
| URL
| Integration guide

| Chainlink
| https://chain.link/[chain.link^]
| https://docs.chain.link/data-feeds/starknet/[docs.chain.link/data-feeds/starknet^]

| Pragma
| https://www.pragma.build/[pragma.build^]
| https://docs.pragma.build/v1/Resources/Consuming%20Data%20Feed/[docs.pragma.build/v1/Resources/ConsumingDataFeed^]

| Pyth
| https://www.pyth.network/[pyth.network^]
| https://docs.pyth.network/price-feeds/use-real-time-data/starknet/[docs.pyth.network/price-feeds/use-real-time-data/starknet^]
|===


================================================
FILE: modules/archive/pages/ecosystem/fullnodes-rpc-providers.adoc
================================================
= Full nodes and RPC providers

== Full nodes
[%autowidth.stretch,cols=",,",options="header"]
|===
| Name
| URL
| More information

| Juno
| https://github.com/NethermindEth/juno[github.com/NethermindEth/juno^]
| https://www.nethermind.io/juno[nethermind.io/juno]

| Madara
| https://github.com/madara-alliance/madara[github.com/madara-alliance/madara^]
| https://www.madara.build/[madara.build^]

| Pathfinder
| https://github.com/eqlabs/pathfinder[github.com/eqlabs/pathfinder^]
| https://equilibrium.co/projects/pathfinder[equilibrium.co/projects/pathfinder^]
|===

== RPC providers

[TIP]
====
For complete information on the Starknet JSON-RPC API, see https://github.com/starkware-libs/starknet-specs/blob/master/api/starknet_api_openrpc.json[`starknet_api_openrpc.json`^].
====

[%autowidth.stretch,cols=",,",options="header"]
|===
| Name
| URL
| Version support

| Alchemy
| http://www.alchemy.com/starknet[alchemy.com/starknet^]
| https://docs.alchemy.com/reference/starknet-api-faq#what-versions-of-starknet-api-are-supported[docs.alchemy.com/reference/starknet-api-faq^]

| All That Node
| https://www.allthatnode.com/starknet.dsrv[allthatnode.com/starknet.dsrv^]
| N/A

| Blast
| http://blastapi.io/public-api/starknet[blastapi.io/public-api/starknet^]
| https://blastapi.io/public-api/starknet[blastapi.io/public-api/starknet^]

| BlockPI
| http://blockpi.io/starknet[blockpi.io/starknet^]
| N/A

| Chainstack
| https://chainstack.com/build-better-with-starknet/[chainstack.com/build-better-with-starknet^]
| https://docs.chainstack.com/reference/getting-started-starknet#starknet-json-rpc-version-endpoints[docs.chainstack.com/reference/getting-started-starknet^]

| dRPC
| https://drpc.org/chainlist/starknet[drpc.org/chainlist/starknet^]
| N/A 

| Dwellir
| https://www.dwellir.com/[dwellir.com^]
| Use the `/rpc/vX_Y` suffix, as described in https://github.com/eqlabs/pathfinder?tab=readme-ov-file#json-rpc-api[Pathfinder's README^]

| GetBlock
| https://getblock.io/nodes/strk/[getblock.io/nodes/strk^]
| Use the `/rpc/vX_Y` suffix, as described in https://github.com/eqlabs/pathfinder?tab=readme-ov-file#json-rpc-api[Pathfinder's README^]

| Infura
| https://www.infura.io/networks/ethereum/starknet[infura.io/networks/ethereum/starknet^]
| N/A

| Lava
| https://www.lavanet.xyz/[lavanet.xyz^]
| Use the `/rpc/vX_Y` suffix, as described in https://github.com/eqlabs/pathfinder?tab=readme-ov-file#json-rpc-api[Pathfinder's README^]

| NOWNodes
| https://nownodes.io/starknet[nownodes.io/starknet^]
| N/A

| OMNIA
| https://omniatech.io/[omniatech.io^]
| N/A

| OnFinality
| https://onfinality.io/networks/starknet[onfinality.io/networks/starknet^]
| N/A

| QuickNode
| https://www.quicknode.com/chains/strk[quicknode.com/chains/strk^]
| https://www.quicknode.com/docs/starknet#supporting-multiple-versions[quicknode.com/docs/starknet^]

| Spectrum
| https://spectrumnodes.com/[spectrumnodes.com^]
| N/A

| Zan
| https://zan.top/home/node-service[zan.top/home/node-service^]
| Use the `/rpc/vX_Y` suffix, as described in https://github.com/eqlabs/pathfinder?tab=readme-ov-file#json-rpc-api[Pathfinder's README^]
|===



================================================
FILE: modules/archive/pages/ecosystem/indexers-enhanced-apis.adoc
================================================
= Indexers and enhanced APIs

== Indexers

[%autowidth.stretch,cols=",",options="header"]
|===
| Name
| URL

| Apibara
| https://www.apibara.com/[apibara.com^]

| Checkpoint
| https://checkpoint.box/[checkpoint.box^]

| DipDup
| https://dipdup.io/[dipdup.io^]

| Footprint Analytics
| https://www.footprint.network/[footprint.network^]

| SubQuery
| https://subquery.network/[subquery.network^]

| The Graph
| https://thegraph.com/[thegraph.com^]

| Token Flow
| https://tokenflow.live/[tokenflow.live^]
|===

== Enhanced APIs

[cols="1,3",options="header"]
|===
| Name
| URL

| Alchemy
| https://docs.alchemy.com/reference/starknet-api-endpoints#nft-api[docs.alchemy.com/reference/starknet-api-endpoints^]

| ArkProject
| https://www.arkproject.dev/products/nft-api[arkproject.dev/products/nft-api^]

| Blast
| https://docs.blastapi.io/blast-documentation/apis-documentation/builder-api/starknet[docs.blastapi.io/blast-documentation/apis-documentation/builder-api/starknet^]

| Starkscan 
| https://starkscan.co/api-info[starkscan.co/api-info^]
|===



================================================
FILE: modules/archive/pages/ecosystem/open-rpc-endpoints-sepolia-faucets.adoc
================================================
= Open RPC endpoints and Sepolia faucets 

== Open RPC endpoints

[%autowidth.stretch,cols=",,",options="header"]
|===
| Provider
| URL (Mainnet)
| URL (Sepolia)

| Blast
| \https://starknet-mainnet.public.blastapi.io
| \https://starknet-sepolia.public.blastapi.io

| dRPC
| \https://starknet.drpc.org
| \https://starknet-sepolia.drpc.org

| Lava
| \https://rpc.starknet.lava.build:443
| \https://rpc.starknet-testnet.lava.build:443

| OnFinality
| \https://starknet.api.onfinality.io/public (HTTPS) +
wss://starknet.api.onfinality.io/public-ws (WebSocket)
| N/A

| Zan
| \https://api.zan.top/public/starknet-mainnet
| N/A
|===

== Sepolia Faucets
[%autowidth.stretch,cols=",,",options="header"]
|===
| Provider
| URL
| Tokens

| Starknet Foundation
| https://faucet.starknet.io/[faucet.starknet.io^]
| STRK and ETH

| Alchemy
| https://www.alchemy.com/faucets/starknet-sepolia[alchemy.com/faucets/starknet-sepolia^]
| ETH
|===



================================================
FILE: modules/archive/pages/ecosystem/wallets-onramps.adoc
================================================
= Wallets and on-ramps

== Wallets

[cols="1,3",options="header"]
|===
| Name
| URL

| Braavos
| https://braavos.app/[braavos.app^]

| Keplr
| https://www.keplr.app/[www.keplr.app^]

| Ledger
| https://www.ledger.com/[ledger.com^]

| MetaMask
| https://snaps.consensys.io/starknet[snaps.consensys.io/starknet^]

| Ready
| https://www.ready.co/ready-wallet[www.ready.co/ready-wallet^]
|===

== On-ramps
[%autowidth.stretch,cols=",",options="header"]
|===
| Name
| URL

| Banxa
| https://banxa.com/[banxa.com^]

| Changelly
| https://changelly.com/[changelly.com^]

| Checkout
| https://fun.xyz/[fun.xyz^]

| Moonpay
| https://www.moonpay.com/[moonpay.com^]

| Onramp Money
| https://onramp.money/[onramp.money^]

| Ramp
| https://ramp.network/[ramp.network^]

| Transak
| https://transak.com/[transak.com^]

| Unlimit Crypto
| https://www.crypto.unlimit.com/[crypto.unlimit.com^]
|===



================================================
FILE: modules/archive/pages/starknet-by-example/calling_other_contracts.adoc
================================================
== Calling Other Contracts

In Starknet, contracts can interact with each other through contract
calls. The recommended way to make these calls is using the dispatcher
pattern, which provides type safety and better error handling.

=== Understanding Dispatchers

A dispatcher is an automatically generated struct that handles the
serialization and deserialization of contract calls. To use dispatchers:

[arabic]
. Define the target contract’s interface as a trait with
`#++[++starknet::interface++]++` (`IContract`)
. Import the generated dispatcher types (`IContractDispatcher` and
`IContractDispatcherTrait`)
. Create a dispatcher instance with the target contract’s address

Let’s look at a practical example where one contract (`Caller`)
interacts with another (`Callee`). The `Callee` contract stores a value
that can be set and retrieved:

[source,cairo]
----
// [!include ~/listings/getting-started/calling_other_contracts/src/caller.cairo:callee_contract]
----

The `Caller` contract demonstrates how to use the dispatcher to interact
with `Callee`:

[source,cairo]
----
// [!include ~/listings/getting-started/calling_other_contracts/src/caller.cairo:caller_contract]
----

==== Key Points:

* The `#++[++starknet::interface++]++` attribute automatically generates
the dispatcher types
* Dispatchers handle all the low-level details of contract interaction
* Contract calls are type-safe and checked at compile time
* Each contract maintains its own storage and state

For more details about dispatchers, check out the
https://book.cairo-lang.org/ch102-02-interacting-with-another-contract.html[Cairo
Book].

[NOTE]
====
While you can use the low-level `call++_++contract++_++syscall`
directly, it’s not recommended as it:

* Requires manual serialization/deserialization
* Lacks compile-time type checking
* Is more easy to make mistakes
====



================================================
FILE: modules/archive/pages/starknet-by-example/components-dependencies.adoc
================================================
= Components dependencies

A component with a dependency on a trait `T` can be used in a contract
as long as the contract implements the trait `T`.

We will use a new `Countable` component as an example:

[source,cairo]
----
#[starknet::interface]
pub trait ICountable<TContractState> {
    fn get(self: @TContractState) -> u32;
    fn increment(ref self: TContractState);
}

#[starknet::component]
pub mod countable_component {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    pub struct Storage {
        countable_value: u32,
    }

    #[embeddable_as(Countable)]
    impl CountableImpl<
        TContractState, +HasComponent<TContractState>,
    > of super::ICountable<ComponentState<TContractState>> {
        fn get(self: @ComponentState<TContractState>) -> u32 {
            self.countable_value.read()
        }

        fn increment(ref self: ComponentState<TContractState>) {
            self.countable_value.write(self.countable_value.read() + 1);
        }
    }
}
----

We want to add a way to enable or disable the counter, in a way that
calling `increment` on a disabled counter will not increment it. But we
don’t want to add this switch logic to the `Countable` component itself.
Instead, we add the trait `Switchable` as a dependency to the
`Countable` component.

== Implementation of the trait in the contract

First, we import the `ISwitchable` trait defined in chapter
link:/components/how_to["`Components How-To`"]:

[source,cairo]
----
pub trait ISwitchable<TContractState> {
    fn is_on(self: @TContractState) -> bool;
    fn switch(ref self: TContractState);
}
----

Then we can modify the implementation of the `Countable` component to
depend on the `ISwitchable` trait:

[source,cairo]
----
#[embeddable_as(Countable)]
impl CountableImpl<
    TContractState, +HasComponent<TContractState>, +ISwitchable<TContractState>,
> of ICountable<ComponentState<TContractState>> {
    fn get(self: @ComponentState<TContractState>) -> u32 {
        self.countable_value.read()
    }

    fn increment(ref self: ComponentState<TContractState>) {
        if (self.get_contract().is_on()) {
            self.countable_value.write(self.countable_value.read() + 1);
        }
    }
}
----

A contract that uses the `Countable` component must implement the
`ISwitchable` trait:

[source,cairo]
----
#[starknet::contract]
mod CountableContract {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use components_dependencies::countable_dep_switch::countable_component;
    use components::switchable::ISwitchable;

    component!(path: countable_component, storage: counter, event: CountableEvent);

    #[abi(embed_v0)]
    impl CountableImpl = countable_component::Countable<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        counter: countable_component::Storage,
        switch: bool,
    }

    // Implementation of the dependency:
    #[abi(embed_v0)]
    impl Switchable of ISwitchable<ContractState> {
        fn switch(ref self: ContractState) {
            self.switch.write(!self.switch.read());
        }

        fn is_on(self: @ContractState) -> bool {
            self.switch.read()
        }
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.switch.write(false);
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CountableEvent: countable_component::Event,
    }
}
----

== Implementation of the trait in another component

In the previous example, we implemented the `ISwitchable` trait in the
contract.

We already implemented a link:/components/how_to[`Switchable`] component
that provides an implementation of the `ISwitchable` trait. By using the
`Switchable` component in a contract, we can embed the implementation of
the `ISwitchable` trait in the contract and resolve the dependency on
the `ISwitchable` trait.

[source,cairo]
----
#[starknet::contract]
mod CountableContract {
    use components_dependencies::countable_dep_switch::countable_component;
    use components::switchable::switchable_component;

    component!(path: countable_component, storage: counter, event: CountableEvent);
    component!(path: switchable_component, storage: switch, event: SwitchableEvent);

    #[abi(embed_v0)]
    impl CountableImpl = countable_component::Countable<ContractState>;
    #[abi(embed_v0)]
    impl SwitchableImpl = switchable_component::Switchable<ContractState>;
    impl SwitchableInternalImpl = switchable_component::SwitchableInternalImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        counter: countable_component::Storage,
        #[substorage(v0)]
        switch: switchable_component::Storage,
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        self.switch._off();
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        CountableEvent: countable_component::Event,
        SwitchableEvent: switchable_component::Event,
    }
}
----

== Dependency on other component’s internal functions

The previous example shows how to use the `ISwitchable` trait
implementation from the `Switchable` component inside the `Countable`
component by embedding the implementation in the contract. However,
suppose we would like to turn off the switch after each increment.
There’s no `set` function in the `ISwitchable` trait, so we can’t do it
directly.

But the `Switchable` component implements the internal function
`++_++off` from the `SwitchableInternalTrait` that set the switch to
`false`. We can’t embed `SwitchableInternalImpl`, but we can add
`switchable::HasComponent++<++TContractState++>++` as a dependency
inside `CountableImpl`.

We make the `Countable` component depend on the `Switchable` component.
This will allow to do
`switchable::ComponentState++<++TContractState++>++` -++>++
`TContractState` -++>++
`countable::ComponentState++<++TcontractState++>++` and access the
internal functions of the `Switchable` component inside the `Countable`
component:

[source,cairo]
----
#[starknet::component]
pub mod countable_component {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    use components::countable::ICountable;
    use components::switchable::ISwitchable;

    // Explicitly depends on a component and not a trait
    use components::switchable::switchable_component;
    use switchable_component::{SwitchableInternalImpl, SwitchableInternalTrait};

    #[storage]
    pub struct Storage {
        countable_value: u32,
    }

    #[generate_trait]
    impl GetSwitchable<
        TContractState,
        +HasComponent<TContractState>,
        +switchable_component::HasComponent<TContractState>,
        +Drop<TContractState>,
    > of GetSwitchableTrait<TContractState> {
        fn get_switchable(
            self: @ComponentState<TContractState>,
        ) -> @switchable_component::ComponentState<TContractState> {
            let contract = self.get_contract();
            switchable_component::HasComponent::<TContractState>::get_component(contract)
        }

        fn get_switchable_mut(
            ref self: ComponentState<TContractState>,
        ) -> switchable_component::ComponentState<TContractState> {
            let mut contract = self.get_contract_mut();
            switchable_component::HasComponent::<TContractState>::get_component_mut(ref contract)
        }
    }

    #[embeddable_as(Countable)]
    impl CountableImpl<
        TContractState,
        +HasComponent<TContractState>,
        +ISwitchable<TContractState>,
        +switchable_component::HasComponent<TContractState>,
        +Drop<TContractState>,
    > of ICountable<ComponentState<TContractState>> {
        fn get(self: @ComponentState<TContractState>) -> u32 {
            self.countable_value.read()
        }

        fn increment(ref self: ComponentState<TContractState>) {
            if (self.get_contract().is_on()) {
                self.countable_value.write(self.countable_value.read() + 1);

                // use the switchable component internal function
                let mut switch = self.get_switchable_mut();
                switch._off();
            }
        }
    }
}
----

The `CountableContract` contract remains the same as in the previous
example, only the implementation of the `Countable` component is
different.



================================================
FILE: modules/archive/pages/starknet-by-example/components-storage-collisions.adoc
================================================
= Components storage collisions

Components can declare their own storage variables.

When a contract uses a component, the component storage is merged with
the contract storage. The storage layout is only determined by the
variables names, so variables with the same name will collide.

[NOTE]
====
In a future release, the `#++[++substorage(v1)++]++` will determine the
storage layout based on the component as well, so collisions will be
avoided.
====

A good practice is to prefix the component storage variables with the
component name, as shown in the link:/components/how_to[Switchable
component example].

== Example

Here’s an example of a collision on the `switchable++_++value` storage
variable of the `Switchable` component.

Interface:

[source,cairo]
----
#[starknet::interface]
pub trait ISwitchCollision<TContractState> {
    fn set(ref self: TContractState, value: bool);
    fn get(ref self: TContractState) -> bool;
}
----

Here’s the storage of the contract:

[source,cairo]
----
#[storage]
#[allow(starknet::colliding_storage_paths)]
struct Storage {
    switchable_value: bool,
    #[substorage(v0)]
    switch: switchable_component::Storage,
}
----

Both the contract and the component have a `switchable++_++value`
storage variable, so they collide:

[source,cairo]
----
fn test_collision() {
    let (mut contract, mut contract_iswitch) = deploy();

    assert_eq!(contract.get(), false);
    assert_eq!(contract_iswitch.is_on(), false);

    contract_iswitch.switch();
    assert_eq!(contract_iswitch.is_on(), true);
    assert_eq!(contract.get(), true);

    // `collision` between component storage 'value' and contract storage 'value'
    assert_eq!(contract.get(), contract_iswitch.is_on());

    contract.set(false);
    assert_eq!(contract.get(), contract_iswitch.is_on());
}
----



================================================
FILE: modules/archive/pages/starknet-by-example/components.adoc
================================================
= Components

Components are like modular addons that can be snapped into contracts to
add reusable logic, storage, and events. They are used to separate the
core logic from common functionalities, simplifying the contract’s code
and making it easier to read and maintain. It also reduces the risk of
bugs and vulnerabilities by using well-tested components.

Key characteristics:

* Modularity: Easily pluggable into multiple contracts.
* Reusable Logic: Encapsulates specific functionalities.
* Not Standalone: Cannot be declared or deployed independently.

== How to create a component

The following example shows a simple `Switchable` component that can be
used to add a switch that can be either on or off. It contains a storage
variable `switchable++_++value`, a function `switch` and an event
`Switch`.

[NOTE]
====
It is a good practice to prefix the component storage variables with the
component name to link:/components/collisions[avoid collisions].
====

[source,cairo]
----
#[starknet::interface]
pub trait ISwitchable<TContractState> {
    fn is_on(self: @TContractState) -> bool;
    fn switch(ref self: TContractState);
}

#[starknet::component]
pub mod switchable_component {
    use starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    pub struct Storage {
        switchable_value: bool,
    }

    #[derive(Drop, Debug, PartialEq, starknet::Event)]
    pub struct SwitchEvent {}

    #[event]
    #[derive(Drop, Debug, PartialEq, starknet::Event)]
    pub enum Event {
        SwitchEvent: SwitchEvent,
    }

    #[embeddable_as(Switchable)]
    impl SwitchableImpl<
        TContractState, +HasComponent<TContractState>,
    > of super::ISwitchable<ComponentState<TContractState>> {
        fn is_on(self: @ComponentState<TContractState>) -> bool {
            self.switchable_value.read()
        }

        fn switch(ref self: ComponentState<TContractState>) {
            self.switchable_value.write(!self.switchable_value.read());
            self.emit(Event::SwitchEvent(SwitchEvent {}));
        }
    }

    #[generate_trait]
    pub impl SwitchableInternalImpl<
        TContractState, +HasComponent<TContractState>,
    > of SwitchableInternalTrait<TContractState> {
        fn _off(ref self: ComponentState<TContractState>) {
            self.switchable_value.write(false);
        }
    }
}
----

A component is really similar to a contract and can also have:

* An interface defining entrypoints
(`ISwitchableComponent++<++TContractState++>++`)
* A Storage struct
* Events
* Internal functions

It doesn’t have a constructor, but you can create an `++_++init`
internal function and call it from the contract’s constructor. In the
previous example, the `++_++off` function will be used this way.

[NOTE]
====
It’s currently not possible to use the same component multiple times in
the same contract. This is a known limitation that may be lifted in the
future.

For now, you can view components as implementations of specific
interfaces or features (`Ownable`, `Upgradeable`, … ~`able`). This is
why we called the component in the above example `Switchable`, and not
`Switch`; the contract _is switchable_, it does not _have a switch_.
====

== How to use a component

Now that we have a component, we can use it in a contract. The following
contract incorporates the `Switchable` component:

[source,cairo]
----
#[starknet::contract]
pub mod SwitchContract {
    use super::switchable_component;

    component!(path: switchab