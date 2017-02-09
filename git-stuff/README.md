
for skipping output of ipynb files in git
[ref](https://github.com/toobaz/ipynb_output_filter)

```shell
git config --global core.attributesfile ~/neo-human/programs/vanity-fair/let-there-be-light/git-stuff/gitattributes

git config --global filter.dropoutput_ipynb.clean ~/repos/toobaz/ipynb_output_filter/ipynb_output_filter.py

git config --global filter.dropoutput_ipynb.smudge cat
```
