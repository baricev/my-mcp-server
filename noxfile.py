import nox


@nox.session
def format(session: nox.Session) -> None:
  """Format code using Pyink."""
  session.run("uv", "run", "pyink", ".", external=True)


@nox.session
def lint(session: nox.Session) -> None:
  """Run Ruff to lint the project."""
  session.run("uv", "run", "ruff", "check", ".", external=True)


@nox.session
def typecheck(session: nox.Session) -> None:
  """Run mypy to type-check the project."""
  session.run("uv", "run", "mypy", ".", external=True)


@nox.session
def tests(session: nox.Session) -> None:
  """Run the test suite."""
  session.run("uv", "run", "pytest", *session.posargs, external=True)


@nox.session(name="all")
def run_all(session: nox.Session) -> None:
  """Run formatting, linting, type checks, and tests."""
  session.notify("format")
  session.notify("lint")
  session.notify("typecheck")
  session.notify("tests")
