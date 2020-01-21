CREATE TABLE roles (
  role_id SERIAL PRIMARY KEY,
  name TEXT
);

INSERT INTO roles (name) VALUES ('list_owner');
INSERT INTO roles (name) VALUES ('job_seeker');

CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  users_name TEXT,
  display_name TEXT,
  first_name TEXT,
  email TEXT UNIQUE,
  url TEXT,
  role_id INT REFERENCES roles(role_id)
);

INSERT INTO users
  (users_name           , display_name         , first_name, email                    , url           , role_id) VALUES
  ('nis'                , 'Nis Frome'          , 'Nis'     , 'nis@alphahq.com'        , 'nis'         , 1),
  ('building the future', 'Building the Future', 'Aaron'   , 'aaron.davis@alphahq.com', 'btf'         , 1),
  ('drew'               , 'Drew Oros'          , 'Drew'    , 'dreworos@gmail.com'     , 'drew'        , 1),
  ('matt'               , 'The Matt Mafia'     , 'Matt'    , 'matt@attwallaert.com'   , 'mattwallaert', 1),
  ('rich'               , 'Rich'               , 'Rich'    , 'richfay@gmail.com'      , 'rich'        , 1),
  ('shaina'             , 'Shaina Cohen'       , 'Shaina'  , 'shaina324@gmail.com'    , 'shaina'      , 1),
  ('nina'               , 'Nina Sloan'         , 'Nina'    , 'nsloan12@gmail.com'     , 'ninasloan'   , 1),
  ('gianna'             , 'Gianna Summa'       , 'Gianna'  , 'glsumma29@gmail.com'    , 'giannasumma' , 1),
  ('atx built'          , 'ATX Built'          , 'Andy'    , 'andy@atxbuilt.com'      , 'atxbuilt'    , 1),
  ('paul'               , 'Paul Hurwitz'       , 'Paul'    , 'paul@phurwitz.com'      , 'phurwitz'    , 1);

CREATE TABLE companies (
  company_id SERIAL PRIMARY KEY,
  companies_name TEXT UNIQUE,
  module_name TEXT UNIQUE,
  company_url TEXT,
  base_url TEXT,
  scrape_url TEXT,
  type TEXT
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('1010Data', '1010data', 'https://www.1010data.com', 'https://www.1010data.com', 'https://www.1010data.com/company/careers/open-positions', 'cheerio'),
('Abbyson Living', 'abbysonliving', 'https://www.abbyson.com', null, 'https://www.abbyson.com/careers.html', 'cheerio'),
('Aeropay', 'aeropay', 'https://www.aeropay.com', null, 'https://www.builtinchicago.org/company/aeropay/jobs', 'cheerio'),
('Alpha', 'alpha', 'https://alphahq.com', null, 'https://boards.greenhouse.io/embed/job_board?for=alpha&b=https%3A%2F%2Falphahq.com%2Fcareers%2F', 'cheerio'),
('Andrena', 'andrena', 'https://andrena.com', null, 'https://google.com', 'cheerio'),
('Artemis', 'artemis', 'https://artemisag.com', null, 'https://artemis.applytojob.com', 'cheerio'),
('Atlassian', 'atlassian', 'https://www.atlassian.com', 'https://www.atlassian.com', 'https://www.atlassian.com/company/careers/all-jobs?team=Engineering%2CProduct%20Management%2CDesign%2CSupport&location=Austin&search=', 'puppeteer'),
('Beeline', 'beeline', 'https://www.beeline.com', null, 'https://chm.tbe.taleo.net/chm04/ats/careers/v2/searchResults?org=BEELINE&cws=40', 'cheerio'),
('Bitly', 'bitly', 'https://bitly.com/', 'https://bitly.com/', 'https://bitly.com/pages/careers', 'puppeteer'),
('Blink Fitness', 'blinkfitness', 'https://www.blinkfitness.com', null, 'https://careers.blinkfitness.com', 'cheerio'),
('BrandYourself', 'brandyourself', 'https://brandyourself.com', null, 'http://careers.brandyourself.com', 'cheerio'),
('Brilliant Hire', 'brillianthire', 'https://www.brillianthire.io', 'https://www.brillianthire.io', 'https://www.brillianthire.io/careers.html', 'cheerio'),
('Business Insider', 'businessinsider', 'https://businessinsider.com', null, 'https://hire.withgoogle.com/public/jobs/businessinsidercom', 'cheerio'),
('Ceros', 'ceros', 'https://www.ceros.com/', 'http://labs.ceros.com/jobs', 'http://labs.ceros.com/jobs/#/', 'puppeteer'),
('Chainalysis', 'chainalysis', 'https://www.chainalysis.com', 'https://boards.greenhouse.io', 'https://boards.greenhouse.io/chainalysis', 'cheerio'),
('Cherre', 'cherre', 'https://cherre.com', null, 'https://jobs.lever.co/cherre?department=Technology', 'cheerio'),
('Cobalt', 'cobalt', 'https://cobaltrobotics.com', null, 'https://cobaltrobotics.com/careers', 'puppeteer'),
('Conde Nast', 'condenast', 'https://www.condenast.com', null, 'https://condenast.wd5.myworkdayjobs.com/CondeCareers', 'cheerio'),
('Dataminr', 'dataminr', 'https://www.dataminr.com', null, 'https://www.dataminr.com/careers', 'puppeteer'),
('Debtsy', 'debtsy', 'https://www.debtsy.com', null, 'https://www.debtsy.com/careers', 'cheerio'),
('Dentsu Aegis Network', 'dentsuaegisnetwork', 'https://www.dentsuaegisnetwork.com/us/en', null, 'https://www.dentsuaegisnetwork.com/us/en/careers/openings/business%20leadership%20(JFG),https://www.dentsuaegisnetwork.com/us/en/careers/openings/data%20analysis,%20research%20&%20insights,https://www.dentsuaegisnetwork.com/us/en/careers/openings/communications%20&%20marketing,https://www.dentsuaegisnetwork.com/us/en/careers/openings/creative%20(JFG),https://www.dentsuaegisnetwork.com/us/en/careers/openings/media%20investment,https://www.dentsuaegisnetwork.com/us/en/careers/openings/digital%20solutions,https://www.dentsuaegisnetwork.com/us/en/careers/openings/technology,https://www.dentsuaegisnetwork.com/us/en/careers/openings/legal,https://www.dentsuaegisnetwork.com/us/en/careers/openings/business%20support,https://www.dentsuaegisnetwork.com/us/en/careers/openings/client%20leadership,https://www.dentsuaegisnetwork.com/us/en/careers/openings/communication%20solutions,https://www.dentsuaegisnetwork.com/us/en/careers/openings/human%20resources', 'cheerio'),
('Eden Health', 'edenhealth', 'https://www.edenhealth.com', null, 'https://jobs.lever.co/edenhealth', 'cheerio'),
('Electric', 'electricai', 'https://www.electric.ai', null, 'https://boards.greenhouse.io/embed/job_board?for=electricai&b=https%3A%2F%2Fwww.electric.ai%2Fcompany%2Fcareers', 'cheerio'),
('Ellevest', 'ellevest', 'https://www.ellevest.com', null, 'https://boards.greenhouse.io/embed/job_board?for=ellevest&b=https%3A%2F%2Fwww.ellevest.com%2Fcareers', 'cheerio'),
('Fitbit', 'fitbit', 'https://www.fitbit.com', null, 'https://www.fitbit.com/careers/all-openings#department/Software%20Engineering,https://www.fitbit.com/careers/all-openings#department/Product%20Management', 'puppeteer'),
('Gamalon', 'gamalon', 'https://gamalon.com', null, 'https://gamalon.com/careers', 'cheerio'),
('Glia', 'glia', 'https://www.glia.com', 'https://www.glia.com', 'https://www.glia.com/careers-offline', 'cheerio'),
('Gzero Media', 'gzeromedia', 'https://www.gzeromedia.com', null, 'https://www.gzeromedia.com/careers', 'cheerio'),
('Hafta Have', 'haftahave', 'https://haftahave.com', null, 'https://www.builtinla.com/company/hafta-have/jobs', 'cheerio'),
('Heartbeat Health', 'heartbeathealth', 'https://heartbeathealth.com', 'https://heartbeathealth.com', 'https://heartbeathealth.com/careers', 'puppeteer'),
('H-E-B', 'heb', 'https://www.heb.com', 'https://heb.taleo.net', 'https://heb.taleo.net/careersection/ishelpdesk/jobsearch.ftl?lang=en&radiusType=K&searchExpanded=true&keyword=ISHELP3232&radius=1&portal=101430233,https://heb.taleo.net/careersection/productteam/jobsearch.ftl?lang=en&radiusType=K&searchExpanded=true&keyword=PROD3232&radius=1&portal=101430233,https://heb.taleo.net/careersection/designteam/jobsearch.ftl?lang=en&radiusType=K&searchExpanded=true&keyword=DES3232&radius=1&portal=101430233,https://heb.taleo.net/careersection/hebdevelopers/jobsearch.ftl?lang=en&radiusType=K&searchExpanded=true&keyword=DEVS3232&radius=1&portal=101430233,https://heb.taleo.net/careersection/hebmobiledev/jobsearch.ftl?lang=en&radiusType=K&searchExpanded=true&keyword=MOBDEV3232&radius=1&portal=101430233', 'puppeteer'),
('Holler', 'holler', 'https://holler.io', 'https://holler.io', 'https://holler.io/careers', 'cheerio'),
('Horizon Media', 'horizonmedia', 'https://www.horizonmedia.com', null, 'https://www.horizonmedia.com/hiring/career-opportunities', 'cheerio'),
('Inboard Technology', 'inboardtechnology', 'https://www.inboardtechnology.com', null, 'https://hire.withgoogle.com/public/jobs/inboardsportscom', 'cheerio'),
('Indeed', 'indeed', 'https://www.indeed.com', null, 'https://www.indeed.com/cmp/Indeed/jobs?q=&l=Austin%2C+TX#cmp-menu-container', 'cheerio'),
('Invision', 'invision', 'https://www.invisionapp.com', null, 'https://www.invisionapp.com/about/#jobs', 'puppeteer'),
('IPG Mediabrands', 'ipgmediabrands', 'https://www.ipgmediabrands.com', null, 'https://careers.ipgmediabrands.com/us/en/search-results', 'cheerio'),
('Jackpocket', 'jackpocket', 'https://jackpocket.com', null, 'https://jackpocket.com/careers', 'cheerio'),
('Jet', 'jet', 'https://jet.com', null, 'https://careers.jet.com', 'cheerio'),
('Jumpcrew', 'jumpcrew', 'https://jumpcrew.com', null, 'https://careers.smartrecruiters.com/JumpCrew', 'cheerio'),
('Knotch', 'knotch', 'https://www.knotch.it', 'https://careers.knotch.it', 'https://careers.knotch.it/jobs/client-success.html,https://careers.knotch.it/jobs/engineering.html,https://careers.knotch.it/jobs/marketing.html,https://careers.knotch.it/jobs/product.html,https://careers.knotch.it/jobs/sales.html', 'cheerio'),
('Knotel', 'knotel', 'https://knotel.com', null, 'https://www.knotel.com/careers', 'cheerio'),
('Knowable', 'knowable', 'https://www.theknowable.com', 'https://boards.greenhouse.io', 'https://boards.greenhouse.io/knowable', 'cheerio'),
('LeagueApps', 'leagueapps', 'https://leagueapps.com', null, 'https://careers.leagueapps.com/#positions', 'puppeteer'),
('Linkedin', 'linkedin', 'https://www.linkedin.com', null, 'https://www.linkedin.com/jobs/search/?f_C=1337&locationId=OTHERS.worldwide', 'cheerio'),
('Lo3Energy', 'lo3energy', 'https://lo3energy.com', null, 'https://lo3energy.com/careers', 'cheerio'),
('MarketMuse', 'marketmuse', 'https://www.marketmuse.com', 'https://boards.greenhouse.io', 'https://boards.greenhouse.io/marketmuse', 'cheerio'),
('Mastercard', 'mastercard', 'https://www.mastercard.us/en-us.html', null, 'https://mastercard.wd1.myworkdayjobs.com/CorporateCareers', 'cheerio'),
('Meeting Expectations', 'meetingexpectations', 'https://meetingexpectations.com', 'https://www.paycomonline.net', 'https://www.paycomonline.net/v4/ats/web.php/jobs?clientkey=85DE5D3A88C60413CD501291D9E950DB&jpt=', 'puppeteer'),
('mongoDB', 'mongodb', 'https://mongodb.com', 'https://www.mongodb.com/careers', 'https://www.mongodb.com/careers/departments/marketing', 'cheerio'),
('Next Day Better', 'nextdaybetter', 'http://nextdaybetter.com', null, 'http://nextdaybetter.com/careers', 'cheerio'),
('OMD', 'omd', 'https://www.omd.com', null, 'https://omg.taleo.net/careersection/omd_externaljobs/jobsearch.ftl', 'cheerio'),
('Ondeck', 'ondeck', 'https://www.ondeck.com/', null, 'https://www.ondeck.com/careers/opportunities', 'cheerio'),
('Peloton', 'peloton', 'https://www.onepeloton.com', 'https://boards.greenhouse.io', 'https://boards.greenhouse.io/peloton', 'puppeteer'),
('Ping', 'ping', 'https://www.timebyping.com', null, 'https://boards.greenhouse.io/embed/job_board?for=timebyping&b=https%3A%2F%2Fwww.timebyping.com%2Fcareers', 'cheerio'),
('Playbill', 'playbill', 'http://www.playbill.com', null, 'http://www.playbill.com/career', 'cheerio'),
('PWNHealth', 'pwnhealth', 'https://www.pwnhealth.com', null, 'https://www.pwnhealth.com/careers', 'puppeteer'),
('Quantum Metric', 'quantummetric', 'https://www.quantummetric.com', null, 'https://www.quantummetric.com/company', 'puppeteer'),
('Retail Me Not', 'retailmenot', 'https://www.retailmenot.com', null, 'https://jobs.lever.co/retailmenot?location=Austin%2C%20Texas', 'cheerio'),
('Rhone', 'rhone', 'https://www.rhone.com', null, 'https://hire.withgoogle.com/public/jobs/rhonecom', 'cheerio'),
('Serial Box', 'serialbox', 'https://serialbox.com', null, 'https://careers.serialbox.com', 'cheerio'),
('Serino Coyne', 'serinocoyne', 'https://serinocoyne.com', null, 'https://serinocoyne.com/careers', 'puppeteer'),
('Teachable', 'teachable', 'https://teachable.com', 'https://teachable.com', 'https://teachable.com/careers', 'puppeteer'),
('Teampay', 'teampay', 'https://www.teampay.co', null, 'https://www.teampay.co/careers', 'puppeteer'),
('The Knot', 'theknot', 'https://www.theknotww.com', null, 'https://www.theknotww.com/careers-detail/876', 'cheerio'),
('The Variable', 'thevariable', 'https://thevariable.com', 'https://thevariable.com', 'https://thevariable.com/careers', 'cheerio'),
('Troops', 'troopsai', 'https://www.troops.ai', null, 'https://www.troops.ai/careers', 'cheerio'),
('Two Sigma', 'twosigma', 'https://twosigma.com', null, 'https://careers.twosigma.com', 'cheerio'),
('Updater', 'updater', 'https://www.updater.com', null, 'https://boards.greenhouse.io/embed/job_board?for=updater&b=https%3A%2F%2Fwww.updater.com%2Fjobs%2Fopenings', 'cheerio'),
('USAA', 'usaa', 'https://www.usaa.com', 'https://www.usaajobs.com', 'https://www.usaajobs.com/search-jobs/Austin%2C%20TX/1207/4/6252001-4736286-4737316-4671654/30x26715/-97x74306/50/2', 'cheerio'),
('VMLY&R', 'vmlyr', 'https://www.vmlyr.com', 'https://jobs.jobvite.com', 'https://jobs.jobvite.com/vml/jobs/all-jobs', 'cheerio'),
('Voray', 'voray', 'https://voray.com', null, 'https://hire.withgoogle.com/public/jobs/voraycom', 'cheerio'),
('VRBO', 'vrbo', 'https://www.vrbo.com', null, 'https://lifeatexpedia.com/jobs?company=Vrbo&location=United%20States%20-%20Texas%20-%20Austin&job_function=Contact%20Center%20Operations|Development|Product%20Marketing|UI/UX', 'cheerio'),
('Walmart', 'walmart', 'https://walmart.com', null, 'https://careers.walmart.com', 'cheerio'),
('Wethos', 'wethos', 'https://www.wethos.co', 'https://www.wethos.co', 'https://www.wethos.co/careers', 'cheerio'),
('WeWork', 'wework', 'https://www.wework.com', null, 'https://careers.wework.com/c/technology-jobs', 'cheerio'),
('YieldStreet', 'yieldstreet', 'https://yieldstreet.com', null, 'https://hire.withgoogle.com/public/jobs/yieldstreetcom', 'cheerio'),
('Young Alfred', 'youngalfred', 'https://youngalfred.com', null, 'https://youngalfred.com', 'cheerio');

CREATE TABLE users_companies (
  users_companies_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  company_id INT REFERENCES companies(company_id),
  target_jobs TEXT[],
  bad_jobs TEXT[],
  target_depts TEXT[],
  bad_depts TEXT[]
);

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'alpha'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'knotel'),
  '{"marketing", "product", "cmo"}',
  '{"designer", "content", "field"}',
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'troopsai'),
  '{"marketing", "product", "cmo"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'mongodb'),
  '{"marketing", "cmo"}',
  '{"content"}',
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'brandyourself'),
  '{"marketing", "product", "cmo"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'serialbox'),
  '{"marketing", "product", "cmo"}',
  '{"production associate"}',
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'glia'),
  '{"marketing", "product", "cmo"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'jackpocket'),
  '{"marketing", "product", "cmo"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'jet'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'marketmuse'),
  '{"marketing", "product", "cmo"}',
  null,
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'voray'),
  '{"marketing", "product", "cmo"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'chainalysis'),
  '{"marketing", "product", "cmo"}',
  '{"editor", "designer"}',
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'peloton'),
  '{"marketing", "product", "cmo"}',
  '{"analyst", "data", "media"}',
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'businessinsider'),
  null,
  null,
  '{"product", "marketing"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'twosigma'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'teachable'),
  null,
  '{"content", "brand", "social media"}',
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'pwnhealth'),
  '{"marketing", "product"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'yieldstreet'),
  null,
  '{"content", "designer", "analyst", "investor"}',
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'teampay'),
  '{"marketing", "product"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'leagueapps'),
  '{"customer success manager", "web designer", "vp", "marketing"}',
  '{"social media", "content"}',
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'blinkfitness'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'cherre'),
  '{"product"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'holler'),
  '{"marketing", "product"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'electricai'),
  '{"product", "marketing"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nis'),
  (SELECT company_id FROM companies WHERE module_name = 'invision'),
  null,
  null,
  '{"marketing", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'alpha'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'glia'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'abbysonliving'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'brillianthire'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'debtsy'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'edenhealth'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'gzeromedia'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'heartbeathealth'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'inboardtechnology'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'knowable'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'lo3energy'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'nextdaybetter'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'quantummetric'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'rhone'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'serialbox'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'thevariable'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'youngalfred'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'aeropay'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'Building the Future'),
  (SELECT company_id FROM companies WHERE module_name = 'haftahave'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'drew'),
  (SELECT company_id FROM companies WHERE module_name = 'alpha'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'drew'),
  (SELECT company_id FROM companies WHERE module_name = 'glia'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'drew'),
  (SELECT company_id FROM companies WHERE module_name = 'troopsai'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'drew'),
  (SELECT company_id FROM companies WHERE module_name = 'andrena'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'matt'),
  (SELECT company_id FROM companies WHERE module_name = 'ping'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'matt'),
  (SELECT company_id FROM companies WHERE module_name = 'ellevest'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'matt'),
  (SELECT company_id FROM companies WHERE module_name = 'updater'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'matt'),
  (SELECT company_id FROM companies WHERE module_name = 'wethos'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'rich'),
  (SELECT company_id FROM companies WHERE module_name = 'bitly'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'rich'),
  (SELECT company_id FROM companies WHERE module_name = 'ceros'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'rich'),
  (SELECT company_id FROM companies WHERE module_name = 'gamalon'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'rich'),
  (SELECT company_id FROM companies WHERE module_name = 'ondeck'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'rich'),
  (SELECT company_id FROM companies WHERE module_name = 'cobalt'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'rich'),
  (SELECT company_id FROM companies WHERE module_name = 'knotch'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'shaina'),
  (SELECT company_id FROM companies WHERE module_name = 'horizonmedia'),
  '{"director", "vp", "svp"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'shaina'),
  (SELECT company_id FROM companies WHERE module_name = 'omd'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'shaina'),
  (SELECT company_id FROM companies WHERE module_name = 'ipgmediabrands'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'shaina'),
  (SELECT company_id FROM companies WHERE module_name = 'dentsuaegisnetwork'),
  '{"director", "vp", "svp"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'shaina'),
  (SELECT company_id FROM companies WHERE module_name = 'serinocoyne'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'shaina'),
  (SELECT company_id FROM companies WHERE module_name = 'playbill'),
  '{"director", "vp", "svp"}',
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nina'),
  (SELECT company_id FROM companies WHERE module_name = 'beeline'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nina'),
  (SELECT company_id FROM companies WHERE module_name = 'mastercard'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'nina'),
  (SELECT company_id FROM companies WHERE module_name = 'meetingexpectations'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gianna'),
  (SELECT company_id FROM companies WHERE module_name = 'condenast'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'gianna'),
  (SELECT company_id FROM companies WHERE module_name = 'vmlyr'),
  '{"resource manager"}',
  null,
  '{"project management"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'atx built'),
  (SELECT company_id FROM companies WHERE module_name = 'atlassian'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'atx built'),
  (SELECT company_id FROM companies WHERE module_name = 'heb'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'atx built'),
  (SELECT company_id FROM companies WHERE module_name = 'vrbo'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'atx built'),
  (SELECT company_id FROM companies WHERE module_name = 'retailmenot'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'atx built'),
  (SELECT company_id FROM companies WHERE module_name = 'indeed'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'atx built'),
  (SELECT company_id FROM companies WHERE module_name = 'usaa'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'paul'),
  (SELECT company_id FROM companies WHERE module_name = 'fitbit'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'paul'),
  (SELECT company_id FROM companies WHERE module_name = 'linkedin'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'paul'),
  (SELECT company_id FROM companies WHERE module_name = 'wework'),
  null,
  null,
  null,
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'paul'),
  (SELECT company_id FROM companies WHERE module_name = 'dataminr'),
  null,
  null,
  '{"engineering", "product"}',
  null
);
INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'paul'),
  (SELECT company_id FROM companies WHERE module_name = '1010data'),
  '{"engineer", "product"}',
  null,
  null,
  null
);

INSERT INTO users
  (users_name                               , display_name                             , first_name, email                     , url          , role_id) VALUES
  ('PeopleAPI startup employer dashboard MN', 'PeopleAPI startup employer dashboard MN', 'Casey'   , 'casey.allen@peopleapi.co', 'peopleapimn', 1);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Total Expert', 'totalexpert', 'https://totalexpert.com', null, 'https://totalexpert.com/careers', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'PeopleAPI startup employer dashboard MN'),
  (SELECT company_id FROM companies WHERE module_name = 'totalexpert'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Sezzle', 'sezzle', 'https://sezzle.com', null, 'https://google.com', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'PeopleAPI startup employer dashboard MN'),
  (SELECT company_id FROM companies WHERE module_name = 'sezzle'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Foodsby', 'foodsby', 'https://www.foodsby.com', 'https://www.foodsby.com/main', 'https://jobs.jobvite.com/foodsby/?nl=1', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'PeopleAPI startup employer dashboard MN'),
  (SELECT company_id FROM companies WHERE module_name = 'foodsby'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Centriam', 'centriam', 'https://www.centriam.com', null, 'https://www.centriam.com/careers', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'PeopleAPI startup employer dashboard MN'),
  (SELECT company_id FROM companies WHERE module_name = 'centriam'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Dispatch', 'dispatchit', 'https://www.dispatchit.com', null, 'https://newton.newtonsoftware.com/career/CareerHome.action?clientId=8a7883d0670aec4a0167664c8fb34b78&parentUrl=https%3A%2F%2Fwww.dispatchit.com%2Fcareers%2F&gns=', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'PeopleAPI startup employer dashboard MN'),
  (SELECT company_id FROM companies WHERE module_name = 'dispatchit'),
  null,
  '{"part time driver"}',
  null,
  null
);

INSERT INTO users
  (users_name, display_name, first_name, email              , url          , role_id) VALUES
  ('chris'   , 'Productize', 'Chris'   , 'chris@alphahq.com', 'productize', 1);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('John Gannon Blog', 'johngannonblog', 'https://johngannonblog.com', null, 'https://johngannonblog.com', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'chris'),
  (SELECT company_id FROM companies WHERE module_name = 'johngannonblog'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('NEA', 'nea', 'https://www.nea.com', null, 'http://careers.nea.com/careers_home.php', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'chris'),
  (SELECT company_id FROM companies WHERE module_name = 'nea'),
  null,
  null,
  null,
  null
);

INSERT INTO companies (companies_name, module_name, company_url, base_url, scrape_url, type) VALUES
('Andreessen Horowitz', 'a16z', 'https://a16z.com', null, 'https://hire.withgoogle.com/public/jobs/a16zcom?background=rgba(0%2C%200%2C%200%2C%200)&no_padding=1', 'cheerio');

INSERT INTO users_companies (user_id, company_id, target_jobs, bad_jobs, target_depts, bad_depts) VALUES
(
  (SELECT user_id FROM users WHERE users_name ilike 'chris'),
  (SELECT company_id FROM companies WHERE module_name = 'a16z'),
  null,
  null,
  '{"business dev", "product", "sales", "partnerships", "finance", "vc", "data science"}',
  null
);
