#!/usr/bin/zsh

cd ~/neo-human/repos/ipython-contrib/IPython-notebook-extensions
python3 setup.py install --user
# pip3 install --user --upgrade -r requirements.txt
pip3 install --user --upgrade psutil widgetsnbextension
pip3 install --user --upgrade ipython jupyter_client jupyter_core notebook nbconvert nbformat traitlets pyyaml
python3 setup.py install --user
cp -R nbextensions ~/.local/share/jupyter
cp -R templates ~/.local/share/jupyter
cp -R extensions ~/.local/share/jupyter

pip3 install --user --upgrade numpy scipy notebook jupyter matplotlib cairocffi
pip3 install --user --upgrade rope jedi flake8 importmagic
pip3 install --user --upgrade 
pip3 install --user --upgrade jupyter-js-widgets-nbextension
jupyter nbextension enable --py --sys-prefix widgetsnbextension

pip3 install --user --upgrade sklearn sklearn-pandas sklearn-extensions
pip3 install --user --upgrade psutil thefuck youtube-dl coursera-dl

####
# mv ~/.local/lib/python3.5/site-packages/notebook/static/components/MathJax ~/.local/lib/python3.5/site-packages/notebook/static/components/MathJax.bkp.1; ln -s ~/neo-human/repos/MathJax ~/.local/lib/python3.5/site-packages/notebook/static/components
