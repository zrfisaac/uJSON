<!-- # [ zrfisaac ] -->

<!-- # [ about ] -->
<!-- # - author : Isaac Caires -->
<!-- # . - email : zrfisaac@gmail.com -->
<!-- # . - site : zrfisaac.github.io -->

<!-- # [ markdown ] -->
# uJSON 1.0.1

- **Original Author:** Fabio Almeida
- **Email:** fabiorecife@yahoo.com.br
- **License:** GNU Lesser General Public License v2.1 or later
- **Original Project Link:** [uJSON on SourceForge](https://sourceforge.net/projects/is-webstart/files/)

## Overview

**uJSON** is a Delphi library for handling JSON (JavaScript Object Notation) data structures. Originally adapted from a JSON implementation in Java, uJSON is designed to simplify JSON data parsing, creation, and manipulation within Delphi applications. Its primary classes, **TJSONObject** and **TJSONArray**, allow for streamlined, object-oriented access to JSON data.

## Key Features

- **JSON Parsing:** Easily create and parse JSON objects from strings.
- **JSON Manipulation:** Access and modify JSON structures using Delphi-compatible classes and methods.
- **Lightweight & Simple:** Designed for ease of use and fast integration into Delphi projects.
- **Compatibility:** Ideal for Delphi applications needing JSON handling capabilities.

## Usage Examples

- **Creating a JSON Object from a String:**

```delphi
var
  s: string;
  json: TJSONObject;
begin
  s := '{"Commands":[{"Command":"NomeComando", "params":{"param1":1}}]}';
  json := TJSONObject.Create(s);
end;
```

- **Accessing JSON Elements:**
```delphi
json.getJSONArray('Commands'); // Returns a TJSONArray of commands
```

- **Retrieving a String Value:**
```delphi
json.getJSONArray('Commands').getJSONObject(0).getString('Command'); // Returns "NomeComando"
```

## License

uJSON is licensed under the GNU Lesser General Public License (LGPL) version 2.1, or (at your option) any later version. This means you’re free to use, modify, and distribute uJSON, provided you adhere to the LGPL terms. Refer to the LICENSE file for detailed terms or visit the GNU website.

## Acknowledgments

This project was created and adapted for Delphi by Fabio Almeida, inspired by a JSON library in Java (see JSON.org).
