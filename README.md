# ophthalmic-ao-handbook
Educational resource for users and developers of adaptive optics ophthalmoscopy


### Editing Content with Markdown
You can use markdown to style your content without needing to know any html. However, you can also use html in the markdown page if you'd like to apply further customizations.

### Headers

```
# Header 1 with an <h1> tag
## Header 2 with an <h2> tag
```
# Header 1 with an <h1> tag
## Header 2 with an <h2> tag

---

### Emphasis
```
*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

_You **can** combine them_
```
*This text will be italic*
_This will also be italic_

**This text will be bold**
__This will also be bold__

_You **can** combine them_

---

### Lists
#### Unordered
```
* Item 1
* Item 2
  * Item 2a
  * Item 2b
```

* Item 1
* Item 2
  * Item 2a
  * Item 2b

#### Ordered
```
1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b
```

1. Item 1
1. Item 2
1. Item 3
   1. Item 3a
   1. Item 3b

---

### Images

```
![Average gradient of Zernike polynomials over polygons]({{ site.baseurl }}/assets/img/polynomial_thumbnail.jpg)
```
![Average gradient of Zernike polynomials over polygons]({{ site.baseurl }}/assets/img/polynomial_thumbnail.jpg)

---

### Links

```
http://github.com - automatic!
[GitHub](http://github.com)
```
http://github.com - automatic!
[GitHub](http://github.com)

---

### Blockquotes
```
As Kanye West said:

> We're living the future so
> the present is our past.
```
As Kanye West said:

> We're living the future so
> the present is our past.

---

### Inline Code
```
I think you should use an
`<addr>` element here instead.
```
I think you should use an
`<addr>` element here instead.

---

### Task Lists
```
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item
```
- [x] @mentions, #refs, [links](), **formatting**, and <del>tags</del> supported
- [x] list syntax required (any unordered or ordered list supported)
- [x] this is a complete item
- [ ] this is an incomplete item

---

### Tables
```
First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column
```

First Header | Second Header
------------ | -------------
Content from cell 1 | Content from cell 2
Content in the first column | Content in the second column

---

### Formulas
```
# Wrap the formula in a div first
<div>
    \begin{align*}
    f(x) &= x^2\\
    g(x) &= \frac{1}{x}\\
    F(x) &= \int^a_b \frac{1}{3}x^3
    \end{align*}
</div>
```


