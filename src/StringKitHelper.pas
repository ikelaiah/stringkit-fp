unit StringKitHelper;

(*
  StringKitHelper - A string type helper for TStringKit

  This unit provides a string type helper (TStringHelperEx) that wraps the static
  methods of TStringKit, allowing for more natural instance-style method calls
  on string variables and literals.

  Example usage:
    var
      S: string;
    begin
      S := '  hello world  ';
      S := S.Trim; // Instance-style call

      // Original static call still works:
      S := TStringKit.Trim('  hello  ');
    end;

  See docs/stringkit-helper-coverage.md for details.
*)

{$mode objfpc}{$H+}{$J-}
{$modeswitch typehelpers}
interface

uses
  Classes, SysUtils, Types, StringKit, RegExpr;

// Feature toggles
// If no specific feature macro is provided, enable all by default.
{$IFNDEF SK_ANY}
  {$DEFINE SK_ALL}
{$ENDIF}

{$IFDEF SK_ALL}
  {$DEFINE SK_MANIP}
  {$DEFINE SK_MATCH}
  {$DEFINE SK_COMPARE}
  {$DEFINE SK_CASE}
  {$DEFINE SK_VALIDATE}
  {$DEFINE SK_FORMAT}
  {$DEFINE SK_NUMERIC}
  {$DEFINE SK_ENCODE}
  {$DEFINE SK_SPLIT}
  {$DEFINE SK_PHONETIC}
{$ENDIF}

type
  // TStringHelperEx
  TStringHelperEx = type helper for string
  public
    {$IFDEF SK_MANIP}
      {$I 'inc/Manip.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_MATCH}
      {$I 'inc/Match.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_COMPARE}
      {$I 'inc/Compare.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_CASE}
      {$I 'inc/Case.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_VALIDATE}
      {$I 'inc/Validate.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_FORMAT}
      {$I 'inc/Format.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_NUMERIC}
      {$I 'inc/Numeric.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_ENCODE}
      {$I 'inc/Encode.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_SPLIT}
      {$I 'inc/Split.intf.inc'}
    {$ENDIF}

    {$IFDEF SK_PHONETIC}
      {$I 'inc/Phonetic.intf.inc'}
    {$ENDIF}
  end;

implementation

// TStringHelperEx

{$IFDEF SK_MANIP}
  {$I 'inc/Manip.impl.inc'}
{$ENDIF}

{$IFDEF SK_MATCH}
  {$I 'inc/Match.impl.inc'}
{$ENDIF}

{$IFDEF SK_COMPARE}
  {$I 'inc/Compare.impl.inc'}
{$ENDIF}

{$IFDEF SK_CASE}
  {$I 'inc/Case.impl.inc'}
{$ENDIF}

{$IFDEF SK_VALIDATE}
  {$I 'inc/Validate.impl.inc'}
{$ENDIF}

{$IFDEF SK_FORMAT}
  {$I 'inc/Format.impl.inc'}
{$ENDIF}

{$IFDEF SK_NUMERIC}
  {$I 'inc/Numeric.impl.inc'}
{$ENDIF}

{$IFDEF SK_ENCODE}
  {$I 'inc/Encode.impl.inc'}
{$ENDIF}

{$IFDEF SK_SPLIT}
  {$I 'inc/Split.impl.inc'}
{$ENDIF}

{$IFDEF SK_PHONETIC}
  {$I 'inc/Phonetic.impl.inc'}
{$ENDIF}

end.
