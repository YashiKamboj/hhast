<?hh // strict
/**
 * Copyright (c) 2016, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional
 * grant of patent rights can be found in the PATENTS file in the same
 * directory.
 *
 */

namespace Facebook\HHAST\Linters;

use type Facebook\HHAST\EditableSyntax;

class ASTLintError<
  Tnode as EditableSyntax,
  Tlinter as ASTLinter<Tnode>
> extends LintError implements FixableLintError {

  public function __construct(
    protected Tlinter $linter,
    string $description,
    private Tnode $node,
  ) {
    parent::__construct($linter, $description);
  }

  final public function getBlameCode(): string {
    return $this->node->full_text();
  }

  <<__Memoize>>
  final public function getPrettyBlameCode(): string {
    return $this->linter->getPrettyNode($this->node)->full_text();
  }

  final public function isFixable(): bool {
    var_dump('checking fixabliity');
    return $this->linter instanceof AutoFixingASTLinter;
  }

  final public function getReadableFix(): (string, string) {
    $linter = $this->linter;
    invariant(
      $linter instanceof AutoFixingASTLinter,
      "Can't render fix for unfixable lint error",
    );
    return tuple(
      $this->getPrettyBlameCode(),
      $linter->getPrettyNode(
        $linter->getFixedNode($this->node),
      )->full_text(),
    );
  }

  final public function applyFix(): void {
    $linter = $this->linter;
    invariant(
      $linter instanceof AutoFixingASTLinter,
      "Can't render fix for unfixable lint error",
    );
    $old = $this->node;
    $new = $linter->getFixedNode($old);

    $new_ast = $linter->getAST()->replace($new, $old);

    file_put_contents($linter->getFile(), $new_ast->full_text());
  }
}