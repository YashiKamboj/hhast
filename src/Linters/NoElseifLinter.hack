/*
 *  Copyright (c) 2017-present, Facebook, Inc.
 *  All rights reserved.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

namespace Facebook\HHAST\Linters;

use type Facebook\HHAST\{
  ElseifToken,
  ElseToken,
  IfToken,
  EditableList,
  EditableNode,
  Script,
  WhiteSpace,
};
use function Facebook\HHAST\Missing;

final class NoElseifLinter
  extends AutoFixingASTLinter<ElseifToken> {
  <<__Override>>
  protected static function getTargetType(): classname<ElseifToken> {
    return ElseifToken::class;
  }

  const type TContext = Script;

  <<__Override>>
  public function getLintErrorForNode(
    Script $_context,
    ElseifToken $expr,
  ): ?ASTLintError<ElseifToken> {
    return new ASTLintError(
      $this,
      'Do not use "elseif", use "else if" instead.',
      $expr,
    );
  }

  <<__Override>>
  public function getFixedNode(ElseifToken $expr): EditableNode {
    return new EditableList(vec[
      new ElseToken($expr->getLeading(), new WhiteSpace(' ')),
      new IfToken(Missing(), $expr->getTrailing()),
    ]);
  }
}