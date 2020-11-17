---
permalink: /assets/js/search-content.js
---
window.store = {
  //{% assign searchable_pages = site.pages  %}
  //{% assign searchable_documents = site.documents %}
  {% assign searchable_pages = site.html_pages  %}
  {% for page in searchable_pages %}
    {% unless page.search == "exclude" %}
    {% assign searchable_documents = searchable_documents | push: page %}
    {% endunless %}
  {% endfor %}
  {% for doc in searchable_documents %}
    "{{ doc.url | slugify }}": {
      "title": "{{ doc.title | xml_escape }}",
      "author": "{{ doc.author | xml_escape }}",
      "category": "{{ doc.category | xml_escape }}",
      "content": {{ doc.content | strip_html |  jsonify }},
      "url": "{{ doc.url | xml_escape | prepend:site.baseurl }}"
    }
    {% unless forloop.last %},{% endunless %}
  {% endfor %}
}
