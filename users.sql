CREATE USER chatroach;
GRANT INSERT,SELECT ON TABLE chatroach.messages to chatroach;
GRANT INSERT,SELECT ON TABLE chatroach.responses to chatroach;
GRANT INSERT,SELECT,UPDATE ON TABLE chatroach.timeouts to chatroach;
GRANT INSERT,SELECT,UPDATE ON TABLE chatroach.users to chatroach;
GRANT INSERT,SELECT,UPDATE ON TABLE chatroach.surveys to chatroach;
GRANT INSERT,SELECT,UPDATE ON TABLE chatroach.facebook_pages to chatroach;
-- GRANT INSERT,SELECT,UPDATE ON TABLE chatroach.states to chatroach;
