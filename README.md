Naptime
=======

Describe your data model using JSON and have naptime spit out the RESTful API endpoints.

*Why do this?*

Often times when I start a project, I end up designing the API before thinking through the completeness of my data.  This way, I can imagine exactly what I want my data entity to look like using JSON and have `naptime` output all the relevant RESTful API endpoints.

How to use
==========
Create a file that contains your JSON description, eg. example.json and run:

```sh
naptime example.json
```

Example
=======
Here we created a file `person.json` that contains the following description:

```json
{
  "name": "Richard",
  "gender": "male",
  "siblings": {
    "brother": {
      "name": "John",
      "birthdate" : "5/1/1972"
    },
    "sister": "Sarah"
  },
  "address": {
    "street": "582 S Grade",
    "city": "Alpine"
  },
  "employed": "yes"
}
```

Then we ran `ruby naptime.rb person.json` and got the following output:

```sh
POST /person
{"name":"Richard","gender":"male","employed":"yes"}

GET /person/[id]

POST /person/[id]
{"name":"Richard","gender":"male","employed":"yes"}

DELETE /person/[id]

POST /person/[id]/siblings
{"sister":"Sarah"}

GET /person/[id]/siblings/[id]

POST /person/[id]/siblings/[id]
{"sister":"Sarah"}

DELETE /person/[id]/siblings/[id]

POST /person/[id]/siblings/[id]/brother
{"name":"John","birthdate":"5/1/1972"}

GET /person/[id]/siblings/[id]/brother/[id]

POST /person/[id]/siblings/[id]/brother/[id]
{"name":"John","birthdate":"5/1/1972"}

DELETE /person/[id]/siblings/[id]/brother/[id]

POST /person/[id]/address
{"street":"582 S Grade","city":"Alpine"}

GET /person/[id]/address/[id]

POST /person/[id]/address/[id]
{"street":"582 S Grade","city":"Alpine"}

DELETE /person/[id]/address/[id]
```
This output describes the necessary API endpoints to do the CRUD for the described data entity.
