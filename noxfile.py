import nox


@nox.session
def format(session: nox.Session) -> None:
  """Format the codebase using Pyink."""
  session.run("uv", "run", "pyink", ".", external=True)


@nox.session
def lint(session: nox.Session) -> None:
  """Run Ruff to lint the project."""
  session.run("uv", "run", "ruff", "check", ".", "--fix", external=True)


@nox.session
def typecheck(session: nox.Session) -> None:
  """Run mypy to type-check the project."""
  session.run("uv", "run", "mypy", ".", external=True)


@nox.session
def tests(session: nox.Session) -> None:
  """Run the test suite."""
  session.run("uv", "run", "pytest", *session.posargs, external=True)
