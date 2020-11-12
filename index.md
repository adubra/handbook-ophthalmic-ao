---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---


<h1 class="display-4">The Ophthalmic Adaptive Optics Handbook</h1>
<p class="lead">{{ page.description | default: site.description | default: site.github.project_tagline }}</p>
<hr />

## Table of Contents

<ul>
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