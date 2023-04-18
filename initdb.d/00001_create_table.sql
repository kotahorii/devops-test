-- Create DB Tables
CREATE TABLE IF NOT EXISTS users(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    name VARCHAR(255) NOT NULL,
    project_v2 VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS repositories(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    owner VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS issues(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    url VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    closed BOOLEAN NOT NULL DEFAULT 0,
    number INT NOT NULL,
    repository VARCHAR(255) NOT NULL,
    FOREIGN KEY (repository) REFERENCES repositories(id)
);

CREATE TABLE IF NOT EXISTS projects(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    title VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    owner VARCHAR(255) NOT NULL,
    FOREIGN KEY (owner) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS pullrequests(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    base_ref_name VARCHAR(255) NOT NULL,
    closed BOOLEAN NOT NULL DEFAULT 0,
    head_ref_name VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    number INT NOT NULL,
    repository VARCHAR(255) NOT NULL,
    FOREIGN KEY (repository) REFERENCES repositories(id)
);

CREATE TABLE IF NOT EXISTS projectcards(
    id VARCHAR(255) PRIMARY KEY NOT NULL,
    project VARCHAR(255) NOT NULL,
    issue VARCHAR(255),
    pullrequest VARCHAR(255),
    FOREIGN KEY (project) REFERENCES projects(id),
    FOREIGN KEY (issue) REFERENCES issues(id),
    FOREIGN KEY (pullrequest) REFERENCES pullrequests(id)
);

-- Insert initial data
INSERT INTO users(id, name) VALUES
    ('U_1', 'hsaki');

INSERT INTO repositories(id, owner, name) VALUES
    ('REPO_1', 'U_1', 'repo1');

INSERT INTO issues(id, url, title, closed, number, repository) VALUES
    ('ISSUE_1', 'http://example.com/repo1/issue/1', 'First Issue', 1, 1, 'REPO_1'),
    ('ISSUE_2', 'http://example.com/repo1/issue/2', 'Second Issue', 0, 2, 'REPO_1'),
    ('ISSUE_3', 'http://example.com/repo1/issue/3', 'Third Issue', 0, 3, 'REPO_1');

INSERT INTO projects(id, title, url, owner) VALUES
    ('PJ_1', 'My Project', 'http://example.com/project/1', 'U_1');

INSERT INTO pullrequests(id, base_ref_name, closed, head_ref_name, url, number, repository) VALUES
    ('PR_1', 'main', 1, 'feature/kinou1', 'http://example.com/repo1/pr/1', 1, 'REPO_1'),
    ('PR_2', 'main', 0, 'feature/kinou2', 'http://example.com/repo1/pr/2', 2, 'REPO_1');
