CREATE MIGRATION m1ulpnd5c7cc7u2vxa5bnwmq4tznzcu3ur6og6xynizdbzatw64usa
    ONTO initial
{
  CREATE SCALAR TYPE default::Rating EXTENDING enum<PG, R>;
  CREATE FUTURE simple_scoping;
  CREATE TYPE default::Snippet {
      CREATE REQUIRED PROPERTY description: std::str;
      CREATE PROPERTY rating: default::Rating;
      CREATE REQUIRED PROPERTY title: std::str;
  };
};
