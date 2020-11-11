---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

<header class="post-header">
    <h1 class="post-title p-name">{{ site.posts.last.title }}</h1>
    <p class="post-meta">
    <time class="dt-published">{{ site.posts.last.date | date: '%b %-d, %Y' }}</time>
    </p>
</header>

<div class="post-content e-content">
<p>
{{ site.posts.last.content }}
</p>
</div>

