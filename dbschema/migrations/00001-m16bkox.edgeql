CREATE MIGRATION m16bkoxmsbjtjxolef5lntyrvrg3rvb65nsnthf7msx5mqb5wto33a
    ONTO initial
{
  CREATE MODULE foo IF NOT EXISTS;
  CREATE FUTURE simple_scoping;
  CREATE TYPE foo::Movie {
      CREATE REQUIRED PROPERTY description: std::str;
      CREATE REQUIRED PROPERTY title: std::str;
  };
};
