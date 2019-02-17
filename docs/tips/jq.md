Get values out of an array of hashes
------------------------------------

Given this:

```json
[{"text": "hello"}, {"text": "there"}]
```

Run this:

```console
$ cat json | jq '.[].text'
"hello"
"there"
```

Or given this:

```json
{"key": [{"id": 1}, {"id": 2}]}
```

To get the IDs:

```console
$ cat json | jq '.key[].id'
"1"
"2"
```

Pretty-print JSON (with colors!)
--------------------------------

Run it through the "no-op" filter, `.`:

```console
$ echo $json | jq .
```
