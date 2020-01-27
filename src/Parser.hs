module Parser where

keywords :: [String]
keywords = ["break", "case", "catch", "const", "continue", "debugger", "default", "delete", "do", "else", "finally", "for", "function", "if", "in", "instanceof", "new", "return", "switch", "throw", "try", "typeof", "var", "void", "while", "with"]

keywordsAtom :: [String]
keywordsAtom = ["false", "null", "true"]

reservedWords :: [String]
reservedWords = ["abstract", "boolean", "byte", "char", "class", "double", "enum", "export", "extends", "final", "float", "goto", "implements", "import", "int", "interface", "let", "long", "native", "package", "private", "protected", "public", "short", "static", "super", "synchronized", "this", "throws", "transient", "volatile", "yield"]
    ++ keywordsAtom ++ keywords

operators :: [String]
operators = []