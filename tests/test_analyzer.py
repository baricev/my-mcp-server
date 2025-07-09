import shutil
from pathlib import Path

from my_mcp_server.analyzer import build_call_graph


def test_tiny_repo(tmp_path: Path) -> None:
  sample = Path(__file__).parent / "sample_repo"
  dst = tmp_path / "sample_repo"
  shutil.copytree(sample, dst)
  graph = build_call_graph(dst)
  assert graph.node_count == 2, "expected 2 functions"
  assert ("A.foo", "B.bar") in graph.edges
