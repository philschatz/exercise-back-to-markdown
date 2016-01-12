# What is this?

- downloads exercise JSON
- converts HTML to markdown
- converts ^^^ back to HTML  (with some superficial cleanup, see XSLT files)
- prints the diff of the 2 HTML files (no diff means exercise is `OK`)

# Requires

- `brew install jq`  Using https://stedolan.github.io/jq/manual/
- `xsltproc`
- `xmllint`

# To Run

`./do-stuff.sh`  (downloads from `exercises-qa` and grabs the first 500)



# Expected output

```
$ ./do-stuff.sh
mkdir: json/: File exists
mkdir: exercise-temp/: File exists
Downloading and Converting 1
######################################################################## 100.0%
Downloading and Converting 2
######################################################################## 100.0%
Downloading and Converting 3
######################################################################## 100.0%
7d6
<
```


# Errors found

```
Downloading and Converting 26
######################################################################## 100.0%
6,9c6
< The French scientist Jacques Monod famously said, &#xE2;&#x80;&#x9C;Anything found to be true of <em
<       >E. coli</em
<     > must also be true of elephants.&#xE2;&#x80;&#x9D; How is this statement based on the notion that living organisms share a common ancestor?
<
---
> The French scientist Jacques Monod famously said, &#xE2;&#x80;&#x9C;Anything found to be true of *E. coli* must also be true of elephants.&#xE2;&#x80;&#x9D; How is this statement based on the notion that living organisms share a common ancestor?

Downloading and Converting 306
Warning: The HTML tag 'img' on line  cannot have any content - auto-closing it
Warning: No link definition for link ID 'arial' found on line 6
Warning: No link definition for link ID 'arial' found on line 8
Warning: No link definition for link ID 'arial' found on line 10
18c18
<         >s^3\!</span
---
>         >s^3!</span


Downloading and Converting 343
6,10c6
< Explain the difference between the <a
<         href="http://openstaxcollege.org/l/dispersion"
<       >two beakers</a
<     >.
<
---
> Explain the difference between the [two beakers][1].


Downloading and Converting 350
18c18
<         >\text{Na}^{+} \!</span
---
>         >\text{Na}^{+} !</span
21c21
<         >\text{K}^{+} {\!}</span
---
>         >\text{K}^{+} {!}</span


Downloading and Converting 353
15c15
<         >\text{Na}^+/\text{K}^+\!</span
---
>         >\text{Na}^+/\text{K}^+!</span
18c18
<         >\text{Na}^+\!</span
---
>         >\text{Na}^+!</span


Downloading and Converting 411
6,10c6
< Explain how the potential and kinetic energy shown in the <a
<         href="http://openstaxcollege.org/l/simple_pendulum"
<       >pendulum model</a
<     > relates to a child swinging on a swing set.
<
---
> Explain how the potential and kinetic energy shown in the [pendulum model][1] relates to a child swinging on a swing set.

```



# TODO

- [ ] Convert the `<span data-math>[FORMULA]</span>` back into `$$[FORMULA]$$`
- [ ] diff the answer choices too
