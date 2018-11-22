Neovim
======

Setup
-----

### Setting up Python for Neovim

_This assumes that you installed [pyenv][] and [pyenv-virtualenv][]_

```sh
pyenv install 3.6.5
pyenv install 2.7.14

pyenv virtualenv 3.6.5 neovim3
pyenv activate neovim3
pip install --upgrade pip
pip install --upgrade neovim
pyenv which python  # Note the path
pyenv deactivate neovim3

pyenv virtualenv 2.7.14 neovim2
pyenv activate neovim2
pip install --upgrade pip
pip install --upgrade neovim
pyenv which python  # Note the path
pyenv deactivate neovim2
```

[pyenv]: https://github.com/pyenv/pyenv
[pyenv-virtualenv]: https://github.com/pyenv/pyenv-virtualenv
