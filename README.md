# RFC API

This API is for generate a RFC (México), the service cannot generate the 'homoclave' so this generator is complety unofficial.

* Ruby version: 3.0.2
* Rails version: 6.1.4.1
* Database: PostgreSQL

**Usage**

Visit: https://rfc-api-demo.herokuapp.com/rfc/new

**Require parameters**
```
{
  "name": *String*,
  "last_name": *String*,
  "second_last_name": *String*,
  "birthdate": *String* (YYYY-MM-DD)
}
```

**Response**
```
{
  "rfc": *String*,
  "count": *Integer*
}
```
