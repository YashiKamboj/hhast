/**
 * This file is generated. Do not modify it manually!
 *
 * @generated SignedSource<<f52d0a8b1e9e2c31a9b0b67ed0ece675>>
 */
namespace Facebook\HHAST;
use namespace Facebook\TypeAssert;
use namespace HH\Lib\Dict;

<<__ConsistentConstruct>>
final class ErrorSyntax extends Node {

  const string SYNTAX_KIND = 'error';

  private Node $_error;

  public function __construct(
    Node $error,
    ?__Private\SourceRef $source_ref = null,
  ) {
    $this->_error = $error;
    parent::__construct($source_ref);
  }

  <<__Override>>
  public static function fromJSON(
    dict<string, mixed> $json,
    string $file,
    int $initial_offset,
    string $source,
    string $_type_hint,
  ): this {
    $offset = $initial_offset;
    $error = Node::fromJSON(
      /* HH_FIXME[4110] */ $json['error_error'],
      $file,
      $offset,
      $source,
      'Node',
    );
    $error = $error as nonnull;
    $offset += $error->getWidth();
    $source_ref = shape(
      'file' => $file,
      'source' => $source,
      'offset' => $initial_offset,
      'width' => $offset - $initial_offset,
    );
    return new static(/* HH_IGNORE_ERROR[4110] */ $error, $source_ref);
  }

  <<__Override>>
  public function getChildren(): dict<string, Node> {
    return dict[
      'error' => $this->_error,
    ]
      |> Dict\filter_nulls($$);
  }

  <<__Override>>
  public function rewriteChildren<Tret as ?Node>(
    (function(Node, vec<Node>): Tret) $rewriter,
    vec<Node> $parents = vec[],
  ): this {
    $parents[] = $this;
    $error = $rewriter($this->_error, $parents);
    if ($error === $this->_error) {
      return $this;
    }
    return new static(/* HH_FIXME[4110] use `as` */ $error);
  }

  public function getErrorUNTYPED(): ?Node {
    return $this->_error;
  }

  public function withError(Node $value): this {
    if ($value === $this->_error) {
      return $this;
    }
    return new static($value);
  }

  public function hasError(): bool {
    return $this->_error !== null;
  }

  /**
   * @return unknown
   */
  public function getError(): Node {
    return $this->_error;
  }

  /**
   * @return unknown
   */
  public function getErrorx(): Node {
    return $this->getError();
  }
}
