---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
search: exclude
---
<h1 class="mt-3">{{ site.book_title  }}</h1>
<p class="lead">{{ page.description | default: site.description | default: site.github.project_tagline }}</p>
<hr />

## Table of Contents

<ul>
{% for section in site.data.toc.sections %}
    <li>  
        {{ section.title }}
        <ul>
            {% for chapter in section.chapters %}
            {% assign postlookup = site.posts | where: "permalink", chapter.url | first %}
            <li>
            <a class="" href="{{ chapter.url | prepend:site.baseurl }}">{{ postlookup.title }}</a>
            </li>
            {% endfor %}
        </ul>
    </li>
{% endfor %}
<!--
{% for category in site.categories %}
    <li>
    {{ category[0]}} 
        <ul>
    {% for post in category[1] reversed %}
        <li>
        <a class="" href="{{ post.url | prepend:site.baseurl }}">{{ post.title }}</a>
        </li>
    {% endfor %}
        </ul>
    </li>
{% endfor %}
</ul>
//--->