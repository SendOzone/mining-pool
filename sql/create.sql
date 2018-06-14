CREATE DATABASE pool;

CREATE TABLE pool.user (
  id           INTEGER     PRIMARY KEY NOT NULL AUTO_INCREMENT,
  address      VARCHAR(64) NOT NULL UNIQUE
);
CREATE INDEX idx_user_address ON pool.user (address);

CREATE TABLE pool.block (
  id           INTEGER    PRIMARY KEY NOT NULL AUTO_INCREMENT,
  hash         BINARY(32) NOT NULL UNIQUE,
  height       INTEGER    NOT NULL,
  main_chain   BOOLEAN    NOT NULL DEFAULT false
);
CREATE INDEX idx_block_hash ON pool.block (hash);
CREATE INDEX idx_block_height ON pool.block (height);

CREATE TABLE pool.share (
  id           INTEGER    PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user         INTEGER    NOT NULL REFERENCES pool.user(id),
  device       INTEGER    UNSIGNED NOT NULL,
  datetime     BIGINT     NOT NULL,
  prev_block   INTEGER    NOT NULL REFERENCES pool.block(id),
  difficulty   DOUBLE     NOT NULL,
  hash         BINARY(32) NOT NULL UNIQUE
);

CREATE INDEX idx_share_prev ON pool.share (prev_block);
CREATE INDEX idx_share_hash ON pool.share (hash);

CREATE TABLE pool.payin (
  id           INTEGER    PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user         INTEGER    NOT NULL REFERENCES pool.user(id),
  amount       DOUBLE     NOT NULL,
  datetime     BIGINT     NOT NULL,
  block        INTEGER    NOT NULL REFERENCES pool.block(id),
  UNIQUE(user, block)
);

CREATE TABLE pool.payout (
  id           INTEGER    PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user         INTEGER       NOT NULL REFERENCES pool.user(id),
  amount       DOUBLE     NOT NULL,
  datetime     BIGINT     NOT NULL,
  transaction  BINARY(32)
);

CREATE TABLE pool.payout_request (
  id           INTEGER    PRIMARY KEY NOT NULL AUTO_INCREMENT,
  user         INTEGER    NOT NULL UNIQUE REFERENCES pool.user(id)
);
