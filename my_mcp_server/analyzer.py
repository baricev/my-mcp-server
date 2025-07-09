from __future__ import annotations

import ast
from dataclasses import dataclass, field
from pathlib import Path


@dataclass
class CallGraph:
  nodes: set[str] = field(default_factory=set)
  edges: set[tuple[str, str]] = field(default_factory=set)

  @property
  def node_count(self) -> int:
    return len(self.nodes)


def _discover_functions(repo: Path) -> dict[str, str]:
  mapping: dict[str, str] = {}
  for file in repo.rglob("*.py"):
    module = file.stem
    tree = ast.parse(file.read_text())
    for node in tree.body:
      if isinstance(node, ast.FunctionDef):
        fqn = f"{module}.{node.name}"
        mapping[node.name] = fqn
  return mapping


def build_call_graph(repo: Path) -> CallGraph:
  graph = CallGraph()
  mapping = _discover_functions(repo)
  graph.nodes.update(mapping.values())

  for file in repo.rglob("*.py"):
    module = file.stem
    tree = ast.parse(file.read_text())
    for node in tree.body:
      if isinstance(node, ast.FunctionDef):
        caller = f"{module}.{node.name}"
        for sub in ast.walk(node):
          if isinstance(sub, ast.Call) and isinstance(sub.func, ast.Name):
            callee_name = sub.func.id
            callee = mapping.get(callee_name)
            if callee:
              graph.edges.add((caller, callee))
  return graph
