# 28 "pilexer.mll"
 
open Parsing_helper
open Piparser

let create_hashtable size init =
  let tbl = Hashtbl.create size in
  List.iter (fun (key,data) -> Hashtbl.add tbl key data) init;
  tbl

(* Untyped front-end *)

let keyword_table =
  create_hashtable 11
[ "data", DATA;
  "param", PARAM;
  "private", PRIVATE;
(* Common keywords *)
  "new", NEW;
  "out", OUT;
  "in", IN;
  "if", IF;
  "then", THEN;
  "else", ELSE;
  "fun", FUN;
  "equation", EQUATION;
  "reduc", REDUCTION;
  "pred", PREDICATE;
  "process", PROCESS;
  "let", LET;
  "query", QUERY;
  "putbegin", PUTBEGIN;
  "noninterf", NONINTERF;
  "event", EVENT;
  "not", NOT;
  "elimtrue", ELIMTRUE;
  "free", FREE;
  "clauses", CLAUSES;
  "suchthat", SUCHTHAT;
  "nounif", NOUNIF;
  "phase", PHASE;
  "among", AMONG;
  "weaksecret", WEAKSECRET;
  "choice", CHOICE;
  "otherwise", OTHERWISE;
  "can", CANTEXT;
  "fail", FAIL;
  "where", WHERE]


# 52 "pilexer.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base = 
   "\000\000\230\255\231\255\078\000\000\000\237\255\238\255\239\255\
    \240\255\241\255\002\000\243\255\244\255\245\255\246\255\247\255\
    \248\255\250\255\001\000\077\000\096\000\002\000\005\000\255\255\
    \251\255\002\000\232\255\236\255\233\255\030\000\032\000\235\255\
    \234\255\145\000\252\255\253\255\006\000\254\255\054\000\255\255\
    ";
  Lexing.lex_backtrk = 
   "\255\255\255\255\255\255\025\000\025\000\255\255\255\255\255\255\
    \255\255\255\255\013\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\006\000\003\000\002\000\001\000\000\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\001\000\255\255\003\000\255\255\
    ";
  Lexing.lex_default = 
   "\001\000\000\000\000\000\255\255\255\255\000\000\000\000\000\000\
    \000\000\000\000\255\255\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\255\255\255\255\255\255\255\255\255\255\000\000\
    \000\000\255\255\000\000\000\000\000\000\255\255\255\255\000\000\
    \000\000\034\000\000\000\000\000\255\255\000\000\255\255\000\000\
    ";
  Lexing.lex_trans = 
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\021\000\023\000\021\000\021\000\022\000\021\000\023\000\
    \037\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \021\000\011\000\021\000\000\000\000\000\000\000\005\000\000\000\
    \018\000\016\000\007\000\024\000\017\000\004\000\008\000\009\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\006\000\012\000\003\000\010\000\027\000\025\000\
    \026\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\015\000\032\000\014\000\031\000\039\000\
    \000\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\030\000\013\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\020\000\
    \000\000\000\000\000\000\029\000\028\000\000\000\000\000\000\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\000\000\037\000\000\000\000\000\036\000\000\000\
    \000\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\038\000\000\000\000\000\000\000\020\000\
    \000\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \002\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\000\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\000\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\035\000";
  Lexing.lex_check = 
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\000\000\000\000\021\000\000\000\000\000\021\000\022\000\
    \036\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\000\000\021\000\255\255\255\255\255\255\000\000\255\255\
    \000\000\000\000\000\000\018\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\004\000\010\000\
    \025\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\029\000\000\000\030\000\038\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\003\000\000\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\020\000\
    \255\255\255\255\255\255\003\000\003\000\255\255\255\255\255\255\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\255\255\033\000\255\255\255\255\033\000\255\255\
    \255\255\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\033\000\255\255\255\255\255\255\020\000\
    \255\255\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\255\255\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\255\255\
    \020\000\020\000\020\000\020\000\020\000\020\000\020\000\020\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\033\000";
  Lexing.lex_base_code = 
   "";
  Lexing.lex_backtrk_code = 
   "";
  Lexing.lex_default_code = 
   "";
  Lexing.lex_trans_code = 
   "";
  Lexing.lex_check_code = 
   "";
  Lexing.lex_code = 
   "";
}

let rec token lexbuf =
    __ocaml_lex_token_rec lexbuf 0
and __ocaml_lex_token_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 80 "pilexer.mll"
     ( next_line lexbuf; token lexbuf )
# 200 "pilexer.ml"

  | 1 ->
# 82 "pilexer.mll"
     ( token lexbuf )
# 205 "pilexer.ml"

  | 2 ->
# 84 "pilexer.mll"
     ( let s = Lexing.lexeme lexbuf in
	 try
	   Hashtbl.find keyword_table s
         with
           Not_found ->
             IDENT (s, extent lexbuf)
     )
# 216 "pilexer.ml"

  | 3 ->
# 92 "pilexer.mll"
    ( 
      try 
        INT (int_of_string(Lexing.lexeme lexbuf))
      with Failure _ ->
	input_error "Incorrect integer" (extent lexbuf)
    )
# 226 "pilexer.ml"

  | 4 ->
# 98 "pilexer.mll"
       (
         comment lexbuf;
         token lexbuf
       )
# 234 "pilexer.ml"

  | 5 ->
# 102 "pilexer.mll"
      ( COMMA )
# 239 "pilexer.ml"

  | 6 ->
# 103 "pilexer.mll"
      ( LPAREN )
# 244 "pilexer.ml"

  | 7 ->
# 104 "pilexer.mll"
      ( RPAREN )
# 249 "pilexer.ml"

  | 8 ->
# 105 "pilexer.mll"
      ( LBRACKET )
# 254 "pilexer.ml"

  | 9 ->
# 106 "pilexer.mll"
      ( RBRACKET )
# 259 "pilexer.ml"

  | 10 ->
# 107 "pilexer.mll"
      ( BAR )
# 264 "pilexer.ml"

  | 11 ->
# 108 "pilexer.mll"
      ( SEMI )
# 269 "pilexer.ml"

  | 12 ->
# 109 "pilexer.mll"
      ( REPL )
# 274 "pilexer.ml"

  | 13 ->
# 110 "pilexer.mll"
      ( EQUAL )
# 279 "pilexer.ml"

  | 14 ->
# 111 "pilexer.mll"
      ( SLASH )
# 284 "pilexer.ml"

  | 15 ->
# 112 "pilexer.mll"
      ( DOT )
# 289 "pilexer.ml"

  | 16 ->
# 113 "pilexer.mll"
      ( STAR )
# 294 "pilexer.ml"

  | 17 ->
# 114 "pilexer.mll"
      ( COLON )
# 299 "pilexer.ml"

  | 18 ->
# 115 "pilexer.mll"
      ( WEDGE )
# 304 "pilexer.ml"

  | 19 ->
# 116 "pilexer.mll"
       ( RED )
# 309 "pilexer.ml"

  | 20 ->
# 117 "pilexer.mll"
        ( EQUIV )
# 314 "pilexer.ml"

  | 21 ->
# 118 "pilexer.mll"
        ( EQUIVEQ )
# 319 "pilexer.ml"

  | 22 ->
# 119 "pilexer.mll"
       ( DIFF )
# 324 "pilexer.ml"

  | 23 ->
# 120 "pilexer.mll"
        ( BEFORE )
# 329 "pilexer.ml"

  | 24 ->
# 121 "pilexer.mll"
      ( EOF )
# 334 "pilexer.ml"

  | 25 ->
# 122 "pilexer.mll"
    ( input_error "Illegal character" (extent lexbuf) )
# 339 "pilexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_token_rec lexbuf __ocaml_lex_state

and comment lexbuf =
    __ocaml_lex_comment_rec lexbuf 33
and __ocaml_lex_comment_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 125 "pilexer.mll"
       ( )
# 351 "pilexer.ml"

  | 1 ->
# 127 "pilexer.mll"
     ( next_line lexbuf; comment lexbuf )
# 356 "pilexer.ml"

  | 2 ->
# 128 "pilexer.mll"
      ( )
# 361 "pilexer.ml"

  | 3 ->
# 129 "pilexer.mll"
    ( comment lexbuf )
# 366 "pilexer.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf; 
      __ocaml_lex_comment_rec lexbuf __ocaml_lex_state

;;

