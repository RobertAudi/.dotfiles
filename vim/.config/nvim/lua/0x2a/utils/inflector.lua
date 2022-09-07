-- Module: 0x2a.utils.inflector

local M = {}

M.rules = {
  uncountable = {
    "advice",
    "bison",
    "bream",
    "breeches",
    "britches",
    "carp",
    "chassis",
    "clippers",
    "cod",
    "contretemps",
    "corps",
    "debris",
    "diabetes",
    "djinn",
    "eland",
    "electricity",
    "elk",
    "equipment",
    "flounder",
    "furniture",
    "gallows",
    "graffiti",
    "happiness",
    "headquarters",
    "herpes",
    "high-jinks",
    "homework",
    "info",
    "information",
    "innings",
    "jackanapes",
    "jeans",
    "luggage",
    "mackerel",
    "measles",
    "mews",
    "money",
    "mumps",
    "music",
    "news",
    "pincers",
    "pliers",
    "police",
    "proceedings",
    "rabies",
    "rice",
    "salmon",
    "scissors",
    "sea-bass",
    "series",
    "shears",
    "sheep",
    "species",
    "sugar",
    "swine",
    "trout",
    "tuna",
    "water",
    "whiting",
    "wildebeest",
  },

  irregular = {
    { singular = "alumnus", plural = "alumni" },
    { singular = "child", plural = "children" },
    { singular = "goose", plural = "geese" },
    { singular = "move", plural = "moves" },
    { singular = "person", plural = "people" },
    { singular = "safe", plural = "safes" },
    { singular = "sex", plural = "sexes" },
    { singular = "virus", plural = "viruses" },
    { singular = "zombie", plural = "zombies" },
  },

  plural = {
    { pattern = "(.+)$", substitution = "%1s" },
    { pattern = "(.+)s$", substitution = "%1s" },
    { pattern = { "^([aA]x)is$", "^([tT]est)is$" }, substitution = "%1es" },
    { pattern = { "(.*)(octop)us$", "(.*)(vir)us$" }, substitution = "%1%2i" },
    { pattern = { "(.*)(octop)i$", "(.*)(vir)i$" }, substitution = "%1%2i" },
    { pattern = { "(.*)(alias)$", "(.*)(status)$" }, substitution = "%1%2es" },
    { pattern = "(.*)(bus)$", substitution = "%1%2ses" },
    { pattern = { "(.*m)an$", "(.*m)en$" }, substitution = "%1en" },
    { pattern = { "(.*)(tomat)o$", "(.*)(buffal)o$" }, substitution = "%1%2oes" },
    { pattern = "(.*)([ti])um$", substitution = "%1%2a" },
    { pattern = "(.*)([ti])a$", substitution = "%1%2a" },
    { pattern = "(.*)sis$", substitution = "%1ses" },
    { pattern = { "(.*)([^f])fe$", "(.*)([lr])f$" }, substitution = "%1%2ves" },
    { pattern = "(.*)(hive)$", substitution = "%1%2s" },
    { pattern = { "(.*)([^aeiouy])y$", "(.*)(qu)y$" }, substitution = "%1%2ies" },
    { pattern = { "(.*)(x)$", "(.*)(ch)$", "(.*)(ss)$", "(.*)(sh)$" }, substitution = "%1%2es" },
    { pattern = "(.*fish)$", substitution = "%1" },
    { pattern = "(.*deer)$", substitution = "%1" },
    {
      pattern = { "(.*)(matr)ix$", "(.*)(matr)ex$", "(.*)(vert)ix$", "(.*)(vert)ex$", "(.*)(ind)ix$", "(.*)(ind)ex$" },
      substitution = "%1%2ices",
    },
    { pattern = { "^([mM])ouse$", "^([lL])ouse$" }, substitution = "%1ice" },
    { pattern = { "^([mM])ice$", "^([lL])ice$" }, substitution = "%1ice" },
    { pattern = "^([oO]x)$", substitution = "%1en" },
    { pattern = "^([oO]xen)$", substitution = "%1" },
    { pattern = "(.*)(quiz)$", substitution = "%1%2zes" },
  },

  singular = {
    { pattern = "(.*)s$", substitution = "%1" },
    { pattern = "(.*)(ss)$", substitution = "%1%2" },
    { pattern = "(.*)(n)ews$", substitution = "%1%2ews" },
    { pattern = "(.*)([ti])a$", substitution = "%1%2um" },
    {
      pattern = {
        "(.*)(analy)sis$",
        "(.*)(analy)ses$",
        "(.*)(ba)sis$",
        "(.*)(ba)ses$",
        "(.*)(diagno)sis$",
        "(.*)(diagno)ses$",
        "(.*)(parenthe)sis$",
        "(.*)(parenthe)ses$",
        "(.*)(progno)sis$",
        "(.*)(progno)ses$",
        "(.*)(synop)sis$",
        "(.*)(synop)ses$",
        "(.*)(the)sis$",
        "(.*)(the)ses$",
      },
      substitution = "%1%2sis",
    },
    { pattern = { "^([aA]naly)sis$", "^([aA]naly)ses$" }, substitution = "%1sis" },
    { pattern = "(.*)([^f])ves$", substitution = "%1%2fe" },
    { pattern = "(.*)(hive)s$", substitution = "%1%2" },
    { pattern = "(.*)(tive)s$", substitution = "%1%2" },
    { pattern = "(.*)([lr])ves$", substitution = "%1%2f" },
    { pattern = { "(.*)([^aeiouy])ies$", "(.*)(qu)ies$" }, substitution = "%1%2y" },
    { pattern = "(.*)(s)eries$", substitution = "%1%2eries" },
    { pattern = "(.*)(m)ovies$", substitution = "%1%2ovie" },
    { pattern = { "(.*)(x)es$", "(.*)(ch)es$", "(.*)(ss)es$", "(.*)(sh)es$" }, substitution = "%1%2" },
    { pattern = { "^([mM])ice$", "^([lL])ice$" }, substitution = "%1ouse" },
    { pattern = { "(.*)(bus)$", "(.*)(bus)s?es$" }, substitution = "%1%2" },
    { pattern = { "(.*m)en$", "(.*m)an$" }, substitution = "%1an" },
    { pattern = "(.*)(o)es$", substitution = "%1%2" },
    { pattern = "(.*)(shoe)s$", substitution = "%1%2" },
    { pattern = { "(.*)(cris)is$", "(.*)(cris)es$", "(.*)(test)is$", "(.*)(test)es$" }, substitution = "%1%2is" },
    { pattern = "^([aA])x[ie]s$", substitution = "%1xis" },
    { pattern = { "(.*)(octop)us$", "(.*)(octop)i$", "(.*)(vir)us$", "(.*)(vir)i$" }, substitution = "%1%2us" },
    { pattern = { "(.*)(alias)$", "(.*)(alias)es$", "(.*)(status)$", "(.*)(status)es$" }, substitution = "%1%2" },
    { pattern = "^([oO]x)en", substitution = "%1" },
    { pattern = { "(.*)(vert)ices$", "(.*)(ind)ices$" }, substitution = "%1%2ex" },
    { pattern = "(.*)(matr)ices$", substitution = "%1%2ix" },
    { pattern = "(.*fish)$", substitution = "%1" },
    { pattern = "(.*deer)$", substitution = "%1" },
    { pattern = "(.*)(quiz)zes$", substitution = "%1%2" },
    { pattern = "(.*)(database)s$", substitution = "%1%2" },
  },
}

local split_word = function(word)
  local prefix = word:match("^([_.-]+)")
  local suffix = word:match("([_.-]+)$")

  if prefix ~= nil then
    word = word:gsub("^([_.-]+)", "")
  else
    prefix = ""
  end

  if suffix ~= nil then
    word = word:gsub("([_.-]+)$", "")
  else
    suffix = ""
  end

  return { prefix = prefix, middle = word, suffix = suffix }
end

local cases = { "camel_case", "snake_case", "dash_case", "pascal_case" }

-- Return the first index with the given value (or nil if not found).
local index_of = function(tbl, value)
  for i, v in ipairs(tbl) do
    if v == value then
      return i
    end
  end

  return nil
end

local detect_case = function(word)
  word = split_word(word).middle

  local result = { case = nil, index = nil, next_case = nil, next_index = nil }

  if word:match("%l%u") then
    if word:match("^%l") then
      result.case = "camel_case"
    else
      result.case = "pascal_case"
    end
  elseif word:match("_") then
    result.case = "snake_case"
  elseif word:match("-") then
    result.case = "dash_case"
  else
    result.case = cases[1]
    result.index = 1
  end

  result.index = result.index or index_of(cases, result.case)
  result.next_index = result.index + 1

  if result.next_index > #cases then
    result.next_index = 1
  end

  result.next_case = cases[result.next_index]

  return result
end

local apply = function(word, inflection)
  if type(inflection.pattern) == "table" then
    for _, pattern in pairs(inflection.pattern) do
      if string.match(word, pattern) then
        return string.gsub(word, pattern, inflection.substitution)
      end
    end
  elseif type(inflection.pattern) == "string" then
    if string.match(word, inflection.pattern) then
      return string.gsub(word, inflection.pattern, inflection.substitution)
    end
  end

  return nil
end

local is_uncountable = function(word)
  for _, uncountable in pairs(M.rules.uncountable) do
    if tostring(word):lower() == uncountable then
      return true
    end
  end

  return false
end

M.upcase_first = function(word)
  return word:gsub("^%a", string.upper, 1)
end

M.downcase_first = function(word)
  return word:gsub("^%a", string.lower, 1)
end

M.camel_case = function(word)
  word = split_word(word)

  return word.prefix .. M.downcase_first(word.middle:gsub("[_-](.)", word.middle.upper)) .. word.suffix
end

M.pascal_case = function(word)
  word = split_word(word)

  return word.prefix .. M.upcase_first(word.middle:gsub("[_-](.)", word.middle.upper)) .. word.suffix
end

M.snake_case = function(word)
  word = split_word(word)

  return word.prefix .. word.middle:gsub("(%l)(%u)", function(lowercase_letter, uppercase_letter)
    return lowercase_letter .. "_" .. uppercase_letter:lower()
  end):gsub("-", "_"):lower() .. word.suffix
end

M.dash_case = function(word)
  word = split_word(word)

  return word.prefix .. word.middle:gsub("_", "-") .. word.suffix
end

M.cycle_case = function(word)
  return M[detect_case(word).next_case](word)
end

M.pluralize = function(word)
  if type(word) ~= "string" then
    error("Can't pluralize " .. type(word))
  elseif word:match("%S") == nil then
    return word
  end

  local plural = word

  if is_uncountable(word) then
    return word
  end

  for _, inflection in pairs(M.rules.irregular) do
    if inflection.singular == word or inflection.plural == word then
      return inflection.plural
    end
  end

  for _, inflection in pairs(M.rules.plural) do
    local matched = apply(word, inflection)

    if matched ~= nil then
      plural = matched
    end
  end

  return plural
end

M.singularize = function(word)
  if type(word) ~= "string" then
    error("Can't singularize " .. type(word))
  elseif word:match("%S") == nil then
    return word
  end

  local singular = word

  if is_uncountable(word) then
    return word
  end

  for _, inflection in pairs(M.rules.irregular) do
    if inflection.singular == word or inflection.plural == word then
      return inflection.singular
    end
  end

  for _, inflection in pairs(M.rules.singular) do
    local matched = apply(word, inflection)

    if matched ~= nil then
      singular = matched
    end
  end

  return singular
end

-- Aliases

M.upper_first = M.upcase_first

M.camelCase = M.camel_case
M.camelize = M.camel_case
M.camel = M.camel_case

M.PascalCase = M.pascal_case
M.pascal = M.pascal_case

M.snake = M.snake_case
M.underscore = M.snake_case

M.kebab = M.dash_case
M.dash = M.dash_case
M.dasherize = M.dash_case

M.plural = M.pluralize
M.singular = M.singularize

return M
