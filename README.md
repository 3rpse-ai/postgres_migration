<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

# DB Helper

A dart package for generating sql strings for DB migrations. Makes use of darts type system to eliminate human error. No code generation required.

## Features

* Create / Update / Delete Tables
* Create / Update / Delete Columns
    * Set default values
    * Define constraints
* Create / Update / Delete Enums

## Supported postgres data types
---
### Numeric Types ✅

| Type             | Supported  |
|------------------|------------|
| smallint         | ✅         |
| integer          | ✅         |
| bigint           | ✅         |
| decimal          | ✅         |
| numeric          | ✅         |
| real             | ✅         |
| double precision | ✅         |
| smallserial      | ✅         |
| serial           | ✅         |
| bigserial        | ✅         |
---
### Character Types ✅

| Type    | Supported  |
|---------|------------|
| varchar | ✅         |
| char    | ✅         |
| text    | ✅         |

---
### Date/Time Types 

| Type                     | Supported  |
|--------------------------|------------|
| timestamp                | ✅         |
| timestamp with time zone | ✅         |
| date                     | ✅         |
| time                     | ❌ |
| time with time zone      | ❌ |
| interval                 | ✅         |
---

### Boolean Types ✅

| Type    | Supported  |
|---------|------------|
| boolean | ✅         |
---
### Enumerated Types ✅

| Type | Supported  |
|------|------------|
| enum | ✅         |
---
### UUID Type ✅

| Type  | Supported  |
|-------|------------|
| uuid  | ✅         |
---
## Unsupported postgres data type categories

✅ On the roadmap
❔ Considering support
❌ No support planned

> 💡 You can easily support needed types by extending column


| Type Category     | Support Planned  |
|-------------------|------------------|
| Monetary          | ❌               |
| Binary            | ❔               |
| Geometric         | ❌               |
| Network Address   | ❌               |
| Bit String        | ❔               |
| Text Search       | ❔               |
| XML               | ✅               |
| JSON              | ✅               |
| Composite         | ❌               |
| Range             | ❌               |
| Domain            | ❌               |
| Object Identifier | ❌               |
| pg_lsn            | ❌               |
| Pseudo            | ❔               |


## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder. 

```dart
const like = 'sample';
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
