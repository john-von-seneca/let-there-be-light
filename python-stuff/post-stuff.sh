#!/usr/bin/zsh
cd ~/neo-human/repos/IPython-notebook-extensions
python3 setup.py install --user
pip3 install --user --upgrade -r requirements.txt
pip3 install --user --upgrade psutil widgetsnbextension
pip3 install --user --upgrade ipython jupyter_client jupyter_core notebook nbconvert nbformat traitlets pyyaml
python3 setup.py install --user
cp -R nbextensions ~/.local/share/jupyter
cp -R templates ~/.local/share/jupyter
cp -R extensions ~/.local/share/jupyter

pi numpy scipy notebook jupyter matplotlib cairocffi
