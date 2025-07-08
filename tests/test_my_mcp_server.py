"""Tests for my_mcp_server."""

from my_mcp_server import __version__


def test_version() -> None:
  """Test version is set."""
  assert __version__ == "0.1.0"
