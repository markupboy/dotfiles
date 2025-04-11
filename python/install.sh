# Check for UV
if test ! $(which uv)
then
  echo "  Installing UV for you."
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

exit 0
