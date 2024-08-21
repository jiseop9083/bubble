SET foreign_key_checks = 0;
TRUNCATE TABLE users;
TRUNCATE TABLE workspace;
TRUNCATE TABLE bubble;
TRUNCATE TABLE curve;
SET foreign_key_checks = 1;

INSERT INTO Users (id, email, password, name) VALUES
(1, 'alice@example.com', 'password1', 'Alice Johnson'),
(2, 'bob@example.com', 'password2', 'Bob Smith'),
(3, 'carol@example.com', 'password3', 'Carol White'),
(4, 'dave@example.com', 'password4', 'Dave Brown'),
(5, 'eve@example.com', 'password5', 'Eve Davis');

--기존의 UUID: 36자의 문자열 (데이터 32자 + '-' 4자), 16바이트의 바이너리 형식으로 저장
INSERT INTO workspace (id, name, theme, created_at, deleted_at, user_id) VALUES
(UUID_TO_BIN(UUID()), 'Workspace 1', 'Light', CURRENT_TIMESTAMP, NULL, 1),
(UUID_TO_BIN(UUID()), 'Workspace 2', 'Dark', CURRENT_TIMESTAMP, NULL, 2),
(UUID_TO_BIN(UUID()), 'Workspace 3', 'Colorful', CURRENT_TIMESTAMP, NULL, 3);

-- Insert bubbles : 워크스페이스로부터 UUID를 가져와서 넣어준다.
SET @first_workspace_id = (
    SELECT id
    FROM workspace
    ORDER BY id ASC
    LIMIT 1
);
INSERT INTO bubble (id, name, top, leftmost, width, height, path, path_depth, bubblized, visible, workspace_id) VALUES
(1, '/ws1', 10, 20, 100, 50, '/ws1', 1, TRUE, TRUE, @first_workspace_id),
(2, '/ws1/A', 30, 40, 150, 75, '/ws1/A', 2, FALSE, TRUE, @first_workspace_id),
(3, '/ws1/B', 50, 60, 200, 100, '/ws1/B', 2, TRUE, FALSE, @first_workspace_id),
(4, '/ws1/C', 10, 20, 100, 50, '/ws1/C', 2, TRUE, TRUE, @first_workspace_id),
(5, '/ws1/D', 30, 40, 150, 75, '/ws1/D', 2, FALSE, TRUE, @first_workspace_id),
(6, '/ws1/E', 50, 60, 200, 100, '/ws1/E', 2, TRUE, FALSE, @first_workspace_id),
(7, '/ws1/A/Afirst', 10, 20, 100, 50, '/ws1/A/Afirst', 3, TRUE, TRUE, @first_workspace_id),
(8, '/ws1/A/Asecond', 30, 40, 150, 75, '/ws1/A/Asecond', 3, FALSE, TRUE, @first_workspace_id),
(9, '/ws1/B/Bfirst', 50, 60, 200, 100, '/ws1/B/Bfirst', 3, TRUE, FALSE, @first_workspace_id),
(10, '/ws1/B/Bsecond', 10, 20, 100, 50, '/ws1/B/Bsecond', 3, TRUE, TRUE, @first_workspace_id),
(11, '/ws1/B/Bthird', 30, 40, 150, 75, '/ws1/B/Bthird', 3, FALSE, TRUE, @first_workspace_id),
(12, '/ws1/B/Bfirst/BBfirst', 50, 60, 200, 100, '/ws1/B/Bfirst/BBfirst', 4, TRUE, FALSE, @first_workspace_id),
(13, '/ws1/B/Bfirst/BBsecond', 10, 20, 100, 50, '/ws1/B/Bfirst/BBsecond', 4, TRUE, TRUE, @first_workspace_id),
(14, '/ws1/B/Bfirst/BBfirst/BBB', 30, 40, 150, 75, '/ws1/B/Bfirst/BBfirst/BBB', 5, FALSE, TRUE, @first_workspace_id),
(15, '/ws1/B/Bfirst/BBsecond/BBBR', 50, 60, 200, 100, '/ws1/B/Bfirst/BBsecond/BBBR', 5, TRUE, FALSE, @first_workspace_id);


-- Insert curves
INSERT INTO curve (id, color, thickness, control_point, bubble_id) VALUES
(1, 'Red', 2, "0A141F", 1),
(2, 'Blue', 3, "0A141F", 1),
(3, 'Green', 4, "0A141F", 2),
(4, 'Yellow', 5, "0A141F", 3),
(5, 'Purple', 6, "0A141F", 4);

;