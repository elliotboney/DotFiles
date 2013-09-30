function tester()
{
  DIR=$(python -c "import os; print os.path.realpath(\"${1}\")")
  echo $DIR
}