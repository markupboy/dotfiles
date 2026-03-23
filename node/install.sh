if command -v fnm >/dev/null 2>&1;
then 
  dotlog "skip" "fnm already installed"
else
  dotlog "install" "Installing fnm"
  /bin/bash -c "$(curl -fsSL https://fnm.vercel.app/install)"
fi