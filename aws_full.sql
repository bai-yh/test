--
-- PostgreSQL database dump
--

-- Dumped from database version 16.6 (Debian 16.6-1.pgdg120+1)
-- Dumped by pg_dump version 16.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: lx_SeqAuto_data
--

-- *not* creating schema, since initdb creates it

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: batch_job_actuator; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.batch_job_actuator (
    act_code character varying(30) NOT NULL,
    app_name character varying(25) NOT NULL,
    registration_way character varying(10) NOT NULL,
    ip_address character varying(30) NOT NULL,
    status character varying(10) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL
);

--
-- Name: COLUMN batch_job_actuator.act_code; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_actuator.act_code IS '编码';


--
-- Name: COLUMN batch_job_actuator.app_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_actuator.app_name IS '应用名称';


--
-- Name: COLUMN batch_job_actuator.registration_way; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_actuator.registration_way IS '注册方式';


--
-- Name: COLUMN batch_job_actuator.ip_address; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_actuator.ip_address IS 'Ip地址';


--
-- Name: COLUMN batch_job_actuator.status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_actuator.status IS '状态';


--
-- Name: COLUMN batch_job_actuator.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_actuator.create_date IS '创建时间';


--
-- Name: batch_job_chain; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.batch_job_chain (
    job_chain_no character varying(60) NOT NULL,
    description text NOT NULL,
    job_actuator character varying(30) NOT NULL,
    routing_strategy character varying(10) NOT NULL,
    cron character varying(30) NOT NULL,
    executor_strategy character varying(10) NOT NULL,
    sub_task_job text NOT NULL,
    failure_strategy character varying(10) NOT NULL,
    retry_times integer NOT NULL,
    ignore_log character varying(3) NOT NULL,
    status character varying(16) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL
);

--
-- Name: batch_job_log_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.batch_job_log_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: batch_job_log; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.batch_job_log (
    seq_no bigint DEFAULT nextval('public.batch_job_log_seq_no_seq'::regclass) NOT NULL,
    job_log_no character varying(30) NOT NULL,
    job_chain_no character varying(30) NOT NULL,
    job_id character varying(20) NOT NULL,
    job_actuator character varying(30) NOT NULL,
    trigger_mode character varying(10) NOT NULL,
    executor_date timestamp(6) without time zone NOT NULL,
    executor_times bigint,
    end_date timestamp(6) without time zone,
    status character varying(16) NOT NULL,
    exception_msg text
);

--
-- Name: COLUMN batch_job_log.job_log_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.job_log_no IS '日志编号';


--
-- Name: COLUMN batch_job_log.job_chain_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.job_chain_no IS '任务链编号';


--
-- Name: COLUMN batch_job_log.job_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.job_id IS '子任务ID';


--
-- Name: COLUMN batch_job_log.job_actuator; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.job_actuator IS '执行器';


--
-- Name: COLUMN batch_job_log.trigger_mode; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.trigger_mode IS '触发模式（手动，自动）';


--
-- Name: COLUMN batch_job_log.executor_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.executor_date IS '执行时间';


--
-- Name: COLUMN batch_job_log.executor_times; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.executor_times IS '执行时长（秒）';


--
-- Name: COLUMN batch_job_log.end_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.end_date IS '结束时间';


--
-- Name: COLUMN batch_job_log.status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.status IS '状态';


--
-- Name: COLUMN batch_job_log.exception_msg; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.batch_job_log.exception_msg IS '异常原因';


--
-- Name: batch_job_service; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.batch_job_service (
    job_id character varying(60) NOT NULL,
    job_name character varying(60) NOT NULL,
    description text,
    status character varying(3) NOT NULL,
    model character varying(16) NOT NULL,
    create_date date NOT NULL
);


CREATE SEQUENCE public.cm_app_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_app; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_app (
    id bigint DEFAULT nextval('public.cm_app_seq_no_seq'::regclass) NOT NULL,
    acct_no character varying(20),
    org_id character varying(20),
    qr_code_path character varying(100),
    apk_path character varying(100),
    url character varying(100),
    type character varying(10),
    version_code integer
);

--
-- Name: TABLE cm_app; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON TABLE public.cm_app IS 'Android and IOS app download/update data';


--
-- Name: cm_app_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_app_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_application; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_application (
    app_no character varying(50) NOT NULL,
    app_code character varying(50),
    app_name character varying(100) NOT NULL,
    app_type character varying(20),
    management_type character varying(10),
    app_desc character varying,
    app_link character varying(100),
    app_url_prefix character varying(100),
    app_img character varying(100),
    app_status character varying(3) NOT NULL,
    org_id character varying(10) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL,
    create_person character varying(50) NOT NULL,
    app_order character varying(10),
    valid_period_start date,
    valid_period_end date
);

--
-- Name: TABLE cm_application; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON TABLE public.cm_application IS '应用程序注册表';


--
-- Name: COLUMN cm_application.app_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_no IS '应用编号';


--
-- Name: COLUMN cm_application.app_code; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_code IS '应用编码';


--
-- Name: COLUMN cm_application.app_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_name IS '应用名称';


--
-- Name: COLUMN cm_application.app_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_type IS '应用类型（GENERAL:一般应用；BIOLOGICAL:生物信息应用）';


--
-- Name: COLUMN cm_application.management_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.management_type IS '管理类型（SELF:自主管理；PARENT:主系统管理；BOTH:都可管理）';


--
-- Name: COLUMN cm_application.app_desc; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_desc IS '应用描述';


--
-- Name: COLUMN cm_application.app_link; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_link IS '应用地址';


--
-- Name: COLUMN cm_application.app_url_prefix; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_url_prefix IS '接口前缀';


--
-- Name: COLUMN cm_application.app_img; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_img IS '应用图标';


--
-- Name: COLUMN cm_application.app_status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_status IS '应用状态';


--
-- Name: COLUMN cm_application.app_order; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.app_order IS '排序';


--
-- Name: COLUMN cm_application.valid_period_start; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application.valid_period_start IS '生效日期';


--
-- Name: cm_application_related; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_application_related (
    app_no character varying(50) NOT NULL,
    related_no character varying(50) NOT NULL,
    related_type character varying(20) NOT NULL,
    related_status character varying(3),
    org_id character varying(10)
);

--
-- Name: COLUMN cm_application_related.app_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application_related.app_no IS '应用编号';


--
-- Name: COLUMN cm_application_related.related_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application_related.related_no IS '关联的编号';


--
-- Name: COLUMN cm_application_related.related_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_application_related.related_type IS '关联类型（ROLE:角色关联；USER:用户关联）';


--
-- Name: cm_authority_data; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_authority_data (
    rs_no character varying(50) NOT NULL,
    rs_name character varying(60) NOT NULL,
    rs_type character varying(10) NOT NULL,
    rs_url character varying(60),
    parent_no character varying(50) NOT NULL,
    rs_status character varying(3) NOT NULL,
    rs_desc character varying(100),
    rs_order numeric(10,0),
    org_id character varying(30) NOT NULL
);

--
-- Name: COLUMN cm_authority_data.rs_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_no IS '资源代号';


--
-- Name: COLUMN cm_authority_data.rs_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_name IS '资源名称';


--
-- Name: COLUMN cm_authority_data.rs_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_type IS '资源类型';


--
-- Name: COLUMN cm_authority_data.rs_url; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_url IS '资源地址';


--
-- Name: COLUMN cm_authority_data.parent_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.parent_no IS '父代号';


--
-- Name: COLUMN cm_authority_data.rs_status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_status IS '状态 A可用';


--
-- Name: COLUMN cm_authority_data.rs_desc; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_desc IS '资源描述';


--
-- Name: COLUMN cm_authority_data.rs_order; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.rs_order IS '排序';


--
-- Name: COLUMN cm_authority_data.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_authority_data.org_id IS '机构';


--
-- Name: cm_authority_exempt; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_authority_exempt (
    rs_no character varying(50) NOT NULL,
    org_id character varying(30),
    role_no character varying(40)
);


--
-- Name: cm_datasync_register_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_datasync_register_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_datasync_register; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_datasync_register (
    seq_no bigint DEFAULT nextval('public.cm_datasync_register_seq_no_seq'::regclass) NOT NULL,
    app_name character varying(30) NOT NULL,
    app_location character varying(50) NOT NULL,
    register_date date NOT NULL,
    create_date timestamp(6) without time zone NOT NULL
);

--
-- Name: cm_datasync_task_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_datasync_task_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cm_datasync_task; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_datasync_task (
    app_name character varying(30) DEFAULT nextval('public.cm_datasync_task_seq_no_seq'::regclass) NOT NULL,
    source_table character varying(50) NOT NULL,
    target_table character varying(50) NOT NULL,
    target_database character varying(20) NOT NULL,
    primary_key character varying(30) NOT NULL,
    task_type character varying(20) NOT NULL,
    status character varying(10) NOT NULL
);


--
-- Name: COLUMN cm_datasync_task.source_table; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_datasync_task.source_table IS '导出表';


--
-- Name: COLUMN cm_datasync_task.primary_key; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_datasync_task.primary_key IS '主键字段名';


--
-- Name: cm_department_info; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_department_info (
    dp_no character varying(36) NOT NULL,
    dp_name character varying(100) NOT NULL,
    dp_type character varying(10) NOT NULL,
    parent_no character varying(36) NOT NULL,
    dp_status character varying(3) NOT NULL,
    dp_desc character varying(300),
    dp_order numeric(10,0) NOT NULL,
    org_id character varying(30) NOT NULL,
    create_date date
);


--
-- Name: COLUMN cm_department_info.dp_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.dp_no IS '部门ID';


--
-- Name: COLUMN cm_department_info.dp_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.dp_name IS '部门名称';


--
-- Name: COLUMN cm_department_info.dp_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.dp_type IS '部门类别 (默认：General)';


--
-- Name: COLUMN cm_department_info.parent_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.parent_no IS '上级ID';


--
-- Name: COLUMN cm_department_info.dp_status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.dp_status IS '状态 （默认 A）';


--
-- Name: COLUMN cm_department_info.dp_desc; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.dp_desc IS '部门描述';


--
-- Name: COLUMN cm_department_info.dp_order; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.dp_order IS '排序';


--
-- Name: COLUMN cm_department_info.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.org_id IS '机构ID';


--
-- Name: COLUMN cm_department_info.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_department_info.create_date IS '创建时间';


--
-- Name: cm_file_upload; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_file_upload (
    seq_no bigint NOT NULL,
    file_name character varying(50) NOT NULL,
    file_path character varying(200),
    file_type character varying(10) NOT NULL,
    reference_no character varying(50) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL,
    original_file_name character varying(100) NOT NULL
);

--
-- Name: COLUMN cm_file_upload.original_file_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_file_upload.original_file_name IS '文件原始名';


--
-- Name: cm_file_upload_attach; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_file_upload_attach (
    seq_no bigint NOT NULL,
    reference_no character varying(50) NOT NULL,
    file_name character varying(50) NOT NULL,
    original_file_name character varying(100) NOT NULL,
    org_id character varying(20) NOT NULL,
    creator character varying(50) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL,
    tran_date date NOT NULL,
    module character varying(50) NOT NULL,
    status character varying(10)
);

--
-- Name: cm_file_upload_attach_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_file_upload_attach_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_file_upload_attach_seq_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.cm_file_upload_attach_seq_no_seq OWNED BY public.cm_file_upload_attach.seq_no;


--
-- Name: cm_file_upload_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_file_upload_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cm_file_upload_seq_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.cm_file_upload_seq_no_seq OWNED BY public.cm_file_upload.seq_no;


--
-- Name: cm_menu; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_menu (
    menu_no character varying(255) NOT NULL,
    menu_name character varying(60) NOT NULL,
    menu_type character varying(10) NOT NULL,
    parent_no character varying(255) NOT NULL,
    menu_status character varying(3) NOT NULL,
    menu_order numeric(10,0) NOT NULL,
    org_id character varying(30) NOT NULL,
    resource_type character varying(30),
    resource_name character varying(50)
);


--
-- Name: COLUMN cm_menu.menu_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.menu_no IS '编号';


--
-- Name: COLUMN cm_menu.menu_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.menu_name IS '菜单名称';


--
-- Name: COLUMN cm_menu.menu_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.menu_type IS '类型 Root View Data';


--
-- Name: COLUMN cm_menu.parent_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.parent_no IS '父节点编号';


--
-- Name: COLUMN cm_menu.menu_status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.menu_status IS '状态 A可用';


--
-- Name: COLUMN cm_menu.menu_order; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.menu_order IS '排序';


--
-- Name: COLUMN cm_menu.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.org_id IS '机构号';


--
-- Name: COLUMN cm_menu.resource_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.resource_type IS '资源类型 Controller URI Group AuthorityName';


--
-- Name: COLUMN cm_menu.resource_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_menu.resource_name IS '资源名称';


--
-- Name: cm_resources_list_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_resources_list_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_resources_list; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_resources_list (
    seq_no bigint DEFAULT nextval('public.cm_resources_list_seq_no_seq'::regclass) NOT NULL,
    rl_no character varying(50) NOT NULL,
    rs_no character varying(50) NOT NULL,
    rs_type character varying(50) NOT NULL,
    rs_target character varying(60) NOT NULL,
    description character varying(80),
    status character varying(3) NOT NULL,
    org_id character varying(30) NOT NULL
);

--
-- Name: COLUMN cm_resources_list.rl_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.rl_no IS '资源列表编号';


--
-- Name: COLUMN cm_resources_list.rs_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.rs_no IS '资源编号';


--
-- Name: COLUMN cm_resources_list.rs_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.rs_type IS '资源类型';


--
-- Name: COLUMN cm_resources_list.rs_target; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.rs_target IS '资源目标';


--
-- Name: COLUMN cm_resources_list.description; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.description IS '描述';


--
-- Name: COLUMN cm_resources_list.status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.status IS '状态 A 可用';


--
-- Name: COLUMN cm_resources_list.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_resources_list.org_id IS '机构号';


--
-- Name: cm_role_authority; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_role_authority (
    role_no character varying(100) NOT NULL,
    rs_no character varying(100) NOT NULL,
    rs_type character varying(50) NOT NULL,
    org_id character varying(30) NOT NULL
);

--
-- Name: COLUMN cm_role_authority.role_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_authority.role_no IS '角色编号';


--
-- Name: COLUMN cm_role_authority.rs_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_authority.rs_no IS '资源代号';


--
-- Name: COLUMN cm_role_authority.rs_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_authority.rs_type IS '资源类型 Menu Resouces';


--
-- Name: COLUMN cm_role_authority.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_authority.org_id IS '机构ID';


--
-- Name: cm_role_info_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_role_info_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cm_role_info; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_role_info (
    seq_no bigint DEFAULT nextval('public.cm_role_info_seq_no_seq'::regclass) NOT NULL,
    role_no character varying(40) NOT NULL,
    role_name character varying(60) NOT NULL,
    role_type character varying(10) NOT NULL,
    parent_no character varying(40) NOT NULL,
    org_id character varying(30) NOT NULL,
    create_date date
);

--
-- Name: COLUMN cm_role_info.role_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_info.role_no IS '角色编号';


--
-- Name: COLUMN cm_role_info.role_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_info.role_name IS '角色名称';


--
-- Name: COLUMN cm_role_info.role_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_info.role_type IS '类别 Menu Resource Root';


--
-- Name: COLUMN cm_role_info.parent_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_info.parent_no IS '父节点编号';


--
-- Name: COLUMN cm_role_info.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_info.org_id IS '机构ID';


--
-- Name: COLUMN cm_role_info.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_role_info.create_date IS '创建日期';


--
-- Name: cm_system; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_system (
    seq_no bigint NOT NULL,
    sys_code character varying(45) NOT NULL,
    sys_name character varying(60),
    org_id character varying(30) NOT NULL,
    syst_host character varying(60),
    auth_mode character varying(10),
    auth_type character varying(10) NOT NULL,
    sys_status character varying(3) NOT NULL,
    start_date date
);

--
-- Name: COLUMN cm_system.seq_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.seq_no IS '序号';


--
-- Name: COLUMN cm_system.sys_code; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.sys_code IS '代码';


--
-- Name: COLUMN cm_system.sys_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.sys_name IS '名称';


--
-- Name: COLUMN cm_system.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.org_id IS '机构ID';


--
-- Name: COLUMN cm_system.syst_host; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.syst_host IS '主机地址';


--
-- Name: COLUMN cm_system.auth_mode; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.auth_mode IS '认证方式 URL,Modul';


--
-- Name: COLUMN cm_system.auth_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.auth_type IS '认证类别 Menu，Button，Data';


--
-- Name: COLUMN cm_system.sys_status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_system.sys_status IS '系统状态';


--
-- Name: cm_user_department; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_user_department (
    acct_no character varying(50) NOT NULL,
    org_id character varying(30) NOT NULL,
    dp_no character varying(36) NOT NULL
);

--
-- Name: COLUMN cm_user_department.acct_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_department.acct_no IS '账号';


--
-- Name: COLUMN cm_user_department.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_department.org_id IS '机构号';


--
-- Name: COLUMN cm_user_department.dp_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_department.dp_no IS '部门ID';


--
-- Name: cm_user_info; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_user_info (
    seq_no bigint NOT NULL,
    acct_no character varying(50),
    acct_pwd character varying(60),
    user_name character varying(60),
    org_id character varying(30),
    user_type character varying(10),
    user_category character varying(30),
    user_status character varying(3),
    create_date date,
    extension_field character varying
);

--
-- Name: COLUMN cm_user_info.user_category; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_info.user_category IS '用户类别(GENERAL:一般用户；BIOLOGICAL:生物信息用户）';


--
-- Name: COLUMN cm_user_info.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_info.create_date IS '创建日期';


--
-- Name: COLUMN cm_user_info.extension_field; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_info.extension_field IS '附加字段';


--
-- Name: cm_user_info_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_user_info_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_user_info_seq_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.cm_user_info_seq_no_seq OWNED BY public.cm_user_info.seq_no;


--
-- Name: cm_user_openid_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cm_user_openid_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cm_user_openid; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_user_openid (
    seq_no bigint DEFAULT nextval('public.cm_user_openid_seq_no_seq'::regclass) NOT NULL,
    acct_no character varying(50) NOT NULL,
    open_id character varying(50) NOT NULL,
    open_type character varying(20) NOT NULL,
    org_id character varying(30) NOT NULL,
    create_date date
);

--
-- Name: COLUMN cm_user_openid.acct_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_openid.acct_no IS '账号';


--
-- Name: COLUMN cm_user_openid.open_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_openid.open_id IS '绑定账号OpenID';


--
-- Name: COLUMN cm_user_openid.open_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_openid.open_type IS '绑定类型';


--
-- Name: COLUMN cm_user_openid.org_id; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_openid.org_id IS '机构号';


--
-- Name: COLUMN cm_user_openid.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.cm_user_openid.create_date IS '创建日期';


--
-- Name: cm_user_role; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cm_user_role (
    acct_no character varying(50) NOT NULL,
    role_no character varying(40) NOT NULL,
    org_id character varying(30) NOT NULL
);

--
-- Name: cmlog_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cmlog_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cs_category_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cs_category_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cs_category; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cs_category (
    seq_no bigint DEFAULT nextval('public.cs_category_seq_no_seq'::regclass) NOT NULL,
    category_code character varying(100),
    category_name character varying(100),
    status character varying(10),
    org_id character varying(100)
);

--
-- Name: cs_dictionary_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cs_dictionary_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: cs_dictionary; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cs_dictionary (
    seq_no bigint DEFAULT nextval('public.cs_dictionary_seq_no_seq'::regclass) NOT NULL,
    category_seq_no bigint,
    dictionary_code character varying(100),
    dictionary_name character varying(100),
    order_num integer,
    status character varying(20),
    org_id character varying(100),
    extension_field character varying
);

--
-- Name: cs_user_info; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.cs_user_info (
    seq_no integer NOT NULL,
    acct_no character varying(100) NOT NULL,
    org_id character varying(100) NOT NULL,
    info character varying
);

--
-- Name: TABLE cs_user_info; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON TABLE public.cs_user_info IS 'Extra info for user not contain in cm_user_info';


--
-- Name: cs_user_info_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cs_user_info_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;

--
-- Name: cs_user_info_seq_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.cs_user_info_seq_no_seq OWNED BY public.cs_user_info.seq_no;


--
-- Name: cutoff_id; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.cutoff_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: data_etl_hist; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.data_etl_hist (
    reference_no character varying(50) NOT NULL,
    description character varying(50) NOT NULL,
    data_reader character varying(128) NOT NULL,
    data_writer character varying(128) NOT NULL,
    field_mapping character varying,
    split_pk character varying(30),
    batch_num integer NOT NULL,
    reader_object_name character varying(50) NOT NULL,
    writer_object_name character varying(50),
    incremental character varying(3) NOT NULL,
    start_reference character varying(50),
    status character varying(10) NOT NULL,
    run_date date,
    information text,
    creator character varying(50) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL
);


--
-- Name: COLUMN data_etl_hist.reference_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.reference_no IS '编号';


--
-- Name: COLUMN data_etl_hist.description; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.description IS '描述';


--
-- Name: COLUMN data_etl_hist.data_reader; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.data_reader IS 'Reader类型';


--
-- Name: COLUMN data_etl_hist.data_writer; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.data_writer IS 'writer类型';


--
-- Name: COLUMN data_etl_hist.field_mapping; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.field_mapping IS '映射关系';


--
-- Name: COLUMN data_etl_hist.split_pk; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.split_pk IS '分割主键';


--
-- Name: COLUMN data_etl_hist.batch_num; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.batch_num IS '批次数量';


--
-- Name: COLUMN data_etl_hist.reader_object_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.reader_object_name IS 'Reader对象名称';


--
-- Name: COLUMN data_etl_hist.writer_object_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.writer_object_name IS 'Writer对象名称';


--
-- Name: COLUMN data_etl_hist.incremental; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.incremental IS '增量标志 Yes，No';


--
-- Name: COLUMN data_etl_hist.start_reference; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.start_reference IS '增量起始字段';


--
-- Name: COLUMN data_etl_hist.status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.status IS '状态 Prepared Processing Succeeded Failed';


--
-- Name: COLUMN data_etl_hist.run_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.run_date IS '执行日期';


--
-- Name: COLUMN data_etl_hist.information; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.information IS '执行信息';


--
-- Name: COLUMN data_etl_hist.creator; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.creator IS '创建者';


--
-- Name: COLUMN data_etl_hist.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_etl_hist.create_date IS '创建时间';


--
-- Name: data_import_hist; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.data_import_hist (
    reference_no character varying(50) NOT NULL,
    rule_name character varying(50) NOT NULL,
    file_name character varying(200) NOT NULL,
    file_reference character varying(50),
    description text,
    file_path text,
    field_mapping character varying,
    is_check_name character varying(10) NOT NULL,
    data_path text,
    status character varying(10) NOT NULL,
    creator character varying(50) NOT NULL,
    create_date timestamp(6) without time zone NOT NULL
);

--
-- Name: COLUMN data_import_hist.reference_no; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.reference_no IS '流水序号';


--
-- Name: COLUMN data_import_hist.rule_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.rule_name IS '规则名称';


--
-- Name: COLUMN data_import_hist.file_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.file_name IS '导入文件名称';


--
-- Name: COLUMN data_import_hist.file_reference; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.file_reference IS '上传文件参考号';


--
-- Name: COLUMN data_import_hist.description; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.description IS '描述';


--
-- Name: COLUMN data_import_hist.file_path; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.file_path IS '为空，使用了公共上传组件';


--
-- Name: COLUMN data_import_hist.field_mapping; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.field_mapping IS '文件字段与数据库列映射';


--
-- Name: COLUMN data_import_hist.is_check_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.is_check_name IS '是否检查字段名';


--
-- Name: COLUMN data_import_hist.data_path; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.data_path IS '导入数据文件地址';


--
-- Name: COLUMN data_import_hist.status; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.status IS '状态 Prepared Processing Succeeded Failed';


--
-- Name: COLUMN data_import_hist.creator; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.creator IS '创建人';


--
-- Name: COLUMN data_import_hist.create_date; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_hist.create_date IS '创建日期';


--
-- Name: data_import_rule; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.data_import_rule (
    rule_name character varying(50) NOT NULL,
    file_type character varying(10) NOT NULL,
    mode character varying(30) NOT NULL,
    description text NOT NULL,
    table_column text NOT NULL,
    target_table character varying(50) NOT NULL,
    ignore_column text,
    excute_bean_name character varying(50) NOT NULL,
    es_data_service character varying(50),
    delimiter character varying(3) NOT NULL,
    incremental character varying(3) NOT NULL,
    batch_flag character varying(3) NOT NULL,
    commit_num integer NOT NULL
);

--
-- Name: COLUMN data_import_rule.rule_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.rule_name IS '数据导入规则名称';


--
-- Name: COLUMN data_import_rule.file_type; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.file_type IS '导入的文件类型 Excel,Cvs,Txt';


--
-- Name: COLUMN data_import_rule.mode; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.mode IS 'Database,ES,Mixed，File';


--
-- Name: COLUMN data_import_rule.description; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.description IS '规则描述';


--
-- Name: COLUMN data_import_rule.table_column; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.table_column IS '数据表列名';


--
-- Name: COLUMN data_import_rule.target_table; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.target_table IS '导入表名';


--
-- Name: COLUMN data_import_rule.ignore_column; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.ignore_column IS '需要忽略导入的列';


--
-- Name: COLUMN data_import_rule.excute_bean_name; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.excute_bean_name IS '执行需要的Bean名称';


--
-- Name: COLUMN data_import_rule.es_data_service; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.es_data_service IS '如果需要存储es服务';


--
-- Name: COLUMN data_import_rule.delimiter; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.delimiter IS '分隔符，txt时需要';


--
-- Name: COLUMN data_import_rule.incremental; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.incremental IS 'No 全量，Yes 增量';


--
-- Name: COLUMN data_import_rule.batch_flag; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.batch_flag IS '目标表中是否带批量 标记';


--
-- Name: COLUMN data_import_rule.commit_num; Type: COMMENT; Schema: public; Owner: lx_iropa
--

COMMENT ON COLUMN public.data_import_rule.commit_num IS '事物提交数量 定义多少条数据进行提交';


--
-- Name: experimental_data_id; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.experimental_data_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experimental_source_data_compound_id; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.experimental_source_data_compound_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experimental_source_data_compound_id OWNER TO lx_iropa;

--
-- Name: experimental_source_data_id; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.experimental_source_data_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experimental_source_data_id OWNER TO lx_iropa;

--
-- Name: experimental_user_config_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.experimental_user_config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.experimental_user_config_id_seq OWNER TO lx_iropa;

--
-- Name: id_auto_incr; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.id_auto_incr
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.id_auto_incr OWNER TO lx_iropa;

--
-- Name: id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.id_seq OWNER TO lx_iropa;

--
-- Name: process_reactor_list_id; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.process_reactor_list_id
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.process_reactor_list_id OWNER TO lx_iropa;

--
-- Name: process_reactor_list; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.process_reactor_list (
    size bigint,
    cost_rate_cny bigint,
    cost_rate_usd numeric(5,2),
    label character varying(100),
    id integer DEFAULT nextval('public.process_reactor_list_id'::regclass) NOT NULL
);


ALTER TABLE public.process_reactor_list OWNER TO lx_iropa;

--
-- Name: process_selection_seq_no; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.process_selection_seq_no
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.process_selection_seq_no OWNER TO lx_iropa;

--
-- Name: process_selection; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.process_selection (
    id integer DEFAULT nextval('public.process_selection_seq_no'::regclass) NOT NULL,
    history_id character varying(100),
    node_id character varying(100),
    step_name character varying(100),
    weight_sm numeric(12,2),
    weight_sp numeric(12,2),
    step_pmi numeric(12,2),
    reaction_type character varying(200),
    hydrogenation character varying(50),
    reactor smallint,
    volume numeric(12,2),
    reactor_size numeric(12,2),
    batch_number_a integer,
    hour_per_batch numeric(12,2),
    cost_per_hour_a numeric(12,2),
    cost_per_hour_b numeric(12,2),
    material_cost numeric(12,2),
    ecology_cost numeric(12,2),
    factor numeric(12,2),
    step_process_cost_a numeric(12,2),
    step_process_cost_b numeric(12,2),
    total_a numeric(12,2),
    total_b numeric(12,2),
    source character varying(50),
    gmp boolean,
    order_num smallint,
    different_fields character varying(200),
    cost_per_hour_size numeric(12,2),
    batch_number integer,
    cost_per_hour_c numeric(12,2),
    step_process_cost_c numeric(12,2),
    total_c numeric(12,2),
    reactor_size_a numeric(12,2),
    mean numeric(12,2)
);


ALTER TABLE public.process_selection OWNER TO lx_iropa;

--
-- Name: st_analytical_assign_task; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_assign_task (
    id integer NOT NULL,
    analytical_id integer,
    name character varying(255),
    scientist character varying(100),
    status character varying(50),
    review_status character varying(50),
    comments text,
    effective_status character varying(20),
    assign_task_file character varying(255),
    create_time timestamp(6) without time zone,
    creator character varying(100),
    modify_time timestamp(6) without time zone,
    modifier character varying(100),
    receive_date date,
    return_date date
);


ALTER TABLE public.st_analytical_assign_task OWNER TO lx_iropa;

--
-- Name: st_analytical_assign_task_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_assign_task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_analytical_assign_task_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_assign_task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.st_analytical_assign_task_id_seq OWNED BY public.st_analytical_assign_task.id;


--
-- Name: st_analytical_basic; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_basic (
    id integer NOT NULL,
    sir_no character varying(255),
    request_date date,
    requester character varying(255),
    project character varying(255),
    campaign character varying(255),
    step character varying(255),
    imp_identifier character varying(255),
    batch_no character varying(255),
    choose_request character varying(255),
    time_sheet character varying(255),
    basic_file character varying(255),
    create_time timestamp(6) without time zone,
    creator character varying(255),
    modify_time timestamp(6) without time zone,
    modifier character varying(255),
    smiles_code character varying(255),
    structure_edit character varying(255),
    review_status character varying(50),
    nvp_code character varying(50),
    route_id character varying(50),
    node_id character varying(50),
    impurity_id character varying(50),
    batch_id character varying(50),
    chromeleon_add character varying(50)
);


ALTER TABLE public.st_analytical_basic OWNER TO lx_iropa;

--
-- Name: st_analytical_basic_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_basic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_analytical_basic_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_basic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.st_analytical_basic_id_seq OWNED BY public.st_analytical_basic.id;


--
-- Name: st_analytical_investigation; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_investigation (
    id integer NOT NULL,
    analytical_id integer,
    impurity_source text,
    classification text,
    lc_ms jsonb,
    nmr character varying(255)
);


ALTER TABLE public.st_analytical_investigation OWNER TO lx_iropa;

--
-- Name: st_analytical_investigation_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_investigation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_analytical_investigation_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_investigation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.st_analytical_investigation_id_seq OWNED BY public.st_analytical_investigation.id;


--
-- Name: st_analytical_isolation; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_isolation (
    id integer NOT NULL,
    analytical_id integer,
    campaign character varying(100),
    step character varying(100),
    sample_appearance character varying(255),
    sample_amount numeric(10,2),
    content numeric(10,2),
    imp_level numeric(10,2),
    suggested_solvent character varying(100),
    solubility character varying(32),
    rrt character varying(200),
    impurity_amount numeric(10,2),
    exact_mass character varying(50),
    dose_unit character varying(20)
);


ALTER TABLE public.st_analytical_isolation OWNER TO lx_iropa;

--
-- Name: st_analytical_isolation_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_isolation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_analytical_isolation_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_isolation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.st_analytical_isolation_id_seq OWNED BY public.st_analytical_isolation.id;


--
-- Name: st_analytical_merge_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_merge_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 99999
    CACHE 1;


ALTER SEQUENCE public.st_analytical_merge_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_merge_log; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_merge_log (
    id integer DEFAULT nextval('public.st_analytical_merge_id_seq'::regclass) NOT NULL,
    analytical_id integer,
    sir_no character varying(255),
    file_no character varying(255),
    version_no character varying(20),
    create_time timestamp(6) without time zone,
    creator character varying(30)
);


ALTER TABLE public.st_analytical_merge_log OWNER TO lx_iropa;

--
-- Name: st_analytical_registration; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_registration (
    id integer NOT NULL,
    analytical_id integer,
    analyst character varying(255),
    start_date date,
    method_optimization character varying(255),
    method_time character varying(255),
    injection_number character varying(255),
    total_collection_time character varying(255),
    rotary_evaporation character varying(255),
    freeze_drying character varying(255),
    ms_confirmation character varying(255),
    net_cost_time character varying(255),
    deliver_date date,
    cycle_time character varying(255),
    year character varying(255),
    impurity_amount character varying(255),
    recovery character varying(255),
    create_time timestamp(6) without time zone,
    creator character varying(255),
    modify_time timestamp(6) without time zone,
    modifier character varying(255)
);


ALTER TABLE public.st_analytical_registration OWNER TO lx_iropa;

--
-- Name: st_analytical_registration_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_registration_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_analytical_registration_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_registration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.st_analytical_registration_id_seq OWNED BY public.st_analytical_registration.id;


--
-- Name: st_analytical_word_template_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_analytical_word_template_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_analytical_word_template_id_seq OWNER TO lx_iropa;

--
-- Name: st_analytical_word_template; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_analytical_word_template (
    id integer DEFAULT nextval('public.st_analytical_word_template_id_seq'::regclass) NOT NULL,
    name character varying(255),
    content bytea,
    file_no character varying(255)
);


ALTER TABLE public.st_analytical_word_template OWNER TO lx_iropa;

--
-- Name: st_platform_request; Type: TABLE; Schema: public; Owner: lx_iropa
--

CREATE TABLE public.st_platform_request (
    platform_request_id integer NOT NULL,
    project_no character varying(255),
    research_type character varying(255),
    submit_time date,
    expected_deadline date,
    time_card character varying(255),
    contact_person character varying(255),
    phase character varying(255),
    analyst_if_needed character varying(255),
    reaction_type character varying(255),
    project_lead character varying(255),
    platform character varying(255),
    original_result character varying(255),
    expectation character varying(255),
    create_time timestamp(6) without time zone,
    creator character varying(255),
    modify_time timestamp(6) without time zone,
    modifier character varying(255),
    chemist_from_platform character varying(255),
    end_time date,
    status character varying(255),
    hit character varying(255),
    validation character varying(255),
    supply character varying(255),
    enable character varying(255),
    transfer_to_basel character varying(255),
    final_result text,
    supplied_information text,
    comments text,
    upload_file character varying(255),
    online_info character varying(255),
    smiles_step json,
    smiles_result json,
    reaction_scheme character varying(255),
    file_name character varying(255)
);


ALTER TABLE public.st_platform_request OWNER TO lx_iropa;

--
-- Name: st_platform_request_platform_request_id_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.st_platform_request_platform_request_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE public.st_platform_request_platform_request_id_seq OWNER TO lx_iropa;

--
-- Name: st_platform_request_platform_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: lx_iropa
--

ALTER SEQUENCE public.st_platform_request_platform_request_id_seq OWNED BY public.st_platform_request.platform_request_id;


--
-- Name: system_release_information_seq_no_seq; Type: SEQUENCE; Schema: public; Owner: lx_iropa
--

CREATE SEQUENCE public.system_release_information_seq_no_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_release_information_seq_no_seq OWNER TO lx_iropa;

--
-- Name: bl_chemicals id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_chemicals ALTER COLUMN id SET DEFAULT nextval('public.bl_chemicals_id_seq'::regclass);


--
-- Name: bl_cost_material_montitoring id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_cost_material_montitoring ALTER COLUMN id SET DEFAULT nextval('public.bl_cost_material_montitoring_id_seq'::regclass);


--
-- Name: bl_cost_module id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_cost_module ALTER COLUMN id SET DEFAULT nextval('public.bl_cost_module_id_seq'::regclass);


--
-- Name: bl_cost_process_planning id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_cost_process_planning ALTER COLUMN id SET DEFAULT nextval('public.bl_cost_process_planing_id_seq'::regclass);


--
-- Name: bl_edge id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_edge ALTER COLUMN id SET DEFAULT nextval('public.bl_edge_id_seq'::regclass);


--
-- Name: bl_history id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_history ALTER COLUMN id SET DEFAULT nextval('public.bl_history_id_seq'::regclass);


--
-- Name: bl_node id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_node ALTER COLUMN id SET DEFAULT nextval('public.bl_node_id_seq'::regclass);


--
-- Name: bl_preset id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_preset ALTER COLUMN id SET DEFAULT nextval('public.bl_preset_id_seq'::regclass);


--
-- Name: bl_process_flowchart id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_process_flowchart ALTER COLUMN id SET DEFAULT nextval('public.bl_process_flowchart_id_seq'::regclass);


--
-- Name: bl_project_group id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_project_group ALTER COLUMN id SET DEFAULT nextval('public.bl_project_group_id_seq'::regclass);


--
-- Name: bl_project_info id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_project_info ALTER COLUMN id SET DEFAULT nextval('public.bl_project_info_id_seq'::regclass);


--
-- Name: bl_reagent_column_order id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_reagent_column_order ALTER COLUMN id SET DEFAULT nextval('public.bl_reagent_column_order_id_seq'::regclass);


--
-- Name: bl_reagent_data id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_reagent_data ALTER COLUMN id SET DEFAULT nextval('public.bl_reagent_data_id_seq'::regclass);


--
-- Name: bl_route id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_route ALTER COLUMN id SET DEFAULT nextval('public.bl_route_id_seq'::regclass);


--
-- Name: bl_sm_risk_assessment_info id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_sm_risk_assessment_info ALTER COLUMN id SET DEFAULT nextval('public.bl_sm_risk_assessment_info_id_seq'::regclass);


--
-- Name: bl_user_feedback id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_user_feedback ALTER COLUMN id SET DEFAULT nextval('public.bl_user_feedback_id_seq'::regclass);


--
-- Name: cm_file_upload seq_no; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_file_upload ALTER COLUMN seq_no SET DEFAULT nextval('public.cm_file_upload_seq_no_seq'::regclass);


--
-- Name: cm_file_upload_attach seq_no; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_file_upload_attach ALTER COLUMN seq_no SET DEFAULT nextval('public.cm_file_upload_attach_seq_no_seq'::regclass);


--
-- Name: cm_user_info seq_no; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_user_info ALTER COLUMN seq_no SET DEFAULT nextval('public.cm_user_info_seq_no_seq'::regclass);


--
-- Name: cs_user_info seq_no; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cs_user_info ALTER COLUMN seq_no SET DEFAULT nextval('public.cs_user_info_seq_no_seq'::regclass);


--
-- Name: st_analytical_assign_task id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_assign_task ALTER COLUMN id SET DEFAULT nextval('public.st_analytical_assign_task_id_seq'::regclass);


--
-- Name: st_analytical_basic id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_basic ALTER COLUMN id SET DEFAULT nextval('public.st_analytical_basic_id_seq'::regclass);


--
-- Name: st_analytical_investigation id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_investigation ALTER COLUMN id SET DEFAULT nextval('public.st_analytical_investigation_id_seq'::regclass);


--
-- Name: st_analytical_isolation id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_isolation ALTER COLUMN id SET DEFAULT nextval('public.st_analytical_isolation_id_seq'::regclass);


--
-- Name: st_analytical_registration id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_registration ALTER COLUMN id SET DEFAULT nextval('public.st_analytical_registration_id_seq'::regclass);


--
-- Name: st_platform_request platform_request_id; Type: DEFAULT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_platform_request ALTER COLUMN platform_request_id SET DEFAULT nextval('public.st_platform_request_platform_request_id_seq'::regclass);


--
-- Data for Name: batch_job_actuator; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.batch_job_actuator (act_code, app_name, registration_way, ip_address, status, create_date) FROM stdin;
basicPlatformServer-djkVZCS7	basicPlatformServer	Auto	192.168.2.117	A	2023-02-15 17:01:16
\.


--
-- Data for Name: batch_job_chain; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.batch_job_chain (job_chain_no, description, job_actuator, routing_strategy, cron, executor_strategy, sub_task_job, failure_strategy, retry_times, ignore_log, status, create_date) FROM stdin;
JC-database-backupExplore	数据库定时备份任务	basicPlatformServer	RFC	* * 1 * * ?	Serial	1002	FFC	0	IE	A	2022-04-28 00:00:00
JC-database-localBackupExplore	本地数据库定时备份任务	basicPlatformServer	RFC	0 */2 * * * ?	Serial	1007	FFC	0	IE	A	2023-02-15 00:00:00
JC-interval-taskExplore	间隔任务链，包括：发邮件，消息记录及shell执行	basicPlatformServer	RFC	0/5 * * * * ?	Parallel	1004,1006	FFC	0	IE	A	2022-04-28 00:00:00
\.


--
-- Data for Name: batch_job_log; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.batch_job_log (seq_no, job_log_no, job_chain_no, job_id, job_actuator, trigger_mode, executor_date, executor_times, end_date, status, exception_msg) FROM stdin;
\.


--
-- Data for Name: batch_job_service; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.batch_job_service (job_id, job_name, description, status, model, create_date) FROM stdin;
1002	数据库备份服务	数据库备份服务	A	SE	2022-04-28
1004	远程日志记录任务	远程日志记录，包括本地记录及ES记录	A	SE	2022-04-28
1006	远程Shell服务	系统远程shell服务	A	SE	2022-04-28
1007	本地数据库备份服务	本地数据库备份服务	A	SE	2023-02-15
\.


--
-- Data for Name: bl_chemicals; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_chemicals (id, edge_id, chemical_id, category, name, density, volume_number, price, extension_field, name_id, unit, cas, match, unit_eq, tcr, dictionary_name, weight, batch_no, volume_number_new, unit_eq_new, mw_new, density_new, chemical_eq) FROM stdin;
\.


--
-- Data for Name: bl_chemicals_manufacture; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_chemicals_manufacture (edge_id, chemical_id, category, name, density, volume_number, price, extension_field, name_id, unit, cas, match, unit_eq, tcr, dictionary_name, weight, batch_no, record_number, id, node_id, chemical_original_id, volume_number_new, unit_eq_new, history_id, mw_new, density_new, chemical_eq) FROM stdin;
\.


--
-- Data for Name: bl_cost_material_montitoring; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_cost_material_montitoring (id, root_id, bl_cost_chemicals_json) FROM stdin;
\.


--
-- Data for Name: bl_cost_module; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_cost_module (id, in_label, out_label, mw_in, mw_out, weight_out, equivalent, mol_in, mol_out, weight_in, yield, synchro_factor, yield_adjusted, bl_route_id, in_id, out_id, in_price, out_price, bl_cost_chemicals_json) FROM stdin;
\.


--
-- Data for Name: bl_cost_process_planning; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_cost_process_planning (id, route_id, bl_cost_chemicals_json) FROM stdin;
\.


--
-- Data for Name: bl_edge; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_edge (id, edge_id, source, target, molar_yield, route_id, history_id, is_latest, extension_field, pmi_source, load_from_preset, molar_yield_min, molar_yield_max, pmi_min, pmi_max, pmi, other_info, category, actual, actual_flag, weight, record_number) FROM stdin;
\.


--
-- Data for Name: bl_edge_manufacture; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_edge_manufacture (id, node_id, record_number, molar_yield, pmi, history_id) FROM stdin;
\.


--
-- Data for Name: bl_es_report; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_es_report (id, cpmi_target, synthesis, cpmi_current, tcr_current, tonnage, convergence, target_tcr, green_target_value, sub_of_concern, un_solvent, en_hotspots, sum_remarks, reason_for_submission, history_id) FROM stdin;
\.


--
-- Data for Name: bl_history; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_history (id, history_id, route_id, type, route_name, project_id, updater, update_date, extension_field, column_10, version_name, phase, longest_route_name, side_chain_all) FROM stdin;
\.


--
-- Data for Name: bl_impurity_profile; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_impurity_profile (id, node_id, luminata_entered, to_luminata, work_status, external_code, nvp_code, acquired_from, smile_code, category, rrt_method, in_silico, source_eln, fate_experiment, spiking_experiment, sample_quantity, location, nmr, csi_status, history_id, cas_number, additional_information, rrt, lc_ms, synthesized_impurity_file_path, stability_issues, spec_control_strategy_rationale, batch_data, fate_experiment_right_node, fate_experiment_left_node, sample_quantity_unit, unique_id) FROM stdin;
\.


--
-- Data for Name: bl_node; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_node (id, node_id, smiles_code, name, sm_attribute, price, nvp_code, img_src, attribute_reference_no, type, route_id, history_id, is_latest, upload_file_reference_no, extension_field, stoichiometry, category, formula, details, mw, name2, start_pmi, start_price, mol, spiking_experiment, tcr, step_no, telescoped, weight, purity, assay, spiking_experiment_right_node, spiking_experiment_left_node, quantity, unit_eq, limiting, density, cpmi) FROM stdin;
\.


--
-- Data for Name: bl_preset; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_preset (id, type, pmi_low, pmi_high, yield_low, yield_high, counts, category, reference_no) FROM stdin;
370	Addition, 1,2-	24.1	93.05	0.73	0.915	20	Carbonyl Chemistry	\N
371	Addition, 1,4-	13.1	22.75	0.81	0.905	11	Carbonyl Chemistry	\N
372	Alcohol Dehydration	51	51	0.89	0.89	1	Hydration/Dehydration	\N
373	Alcohol Oxidation	23.45	38.35	0.83	0.94	19	Oxidation	\N
374	Aldol/Claisen Addition/Condensation	10.8	27.8	0.76	0.915	11	Carbonyl Chemistry	\N
375	Alkene Reduction	18.85	53.2	0.81	0.94	19	Reduction	\N
376	Alkene/Alkyne Hydration	28.2	28.2	0.85	0.85	1	Hydration/Dehydration	\N
377	Alkyne Reduction	11.35	52.825	0.815	0.9375	4	Reduction	\N
378	Alpha Acylation	17	28.5	0.7325	0.9475	8	Carbonyl Chemistry	\N
379	Alpha Alkylation	9.6	66.25	0.7675	0.8975	20	Alkylation	\N
380	Alpha Arylation	22.2	44.35	0.84	0.93	3	C-C Transition Metal Coupling	\N
381	Amidation	19.7	67.2	0.7675	0.92	120	Acyl Substitution	\N
382	Amide Dehydration to Nitrile	12.375	30.45	0.8625	0.98	8	Hydration/Dehydration	\N
383	Amide Hydrolysis	30.95	71.1	0.87	0.915	3	Acyl Substitution	\N
384	Amidine Formation	3.25	17.75	0.725	0.9275	6	Acyl Substitution	\N
385	Arene Reduction	12.45	17.75	0.88	0.96	7	Reduction	\N
386	Baeyer-Villiger	105.2	105.2	0.8	0.8	1	Oxidation	\N
387	Bioconjugation	2487.4	2487.4	0.96	0.96	1	Other	\N
388	Bromodehydration	14.05	20.65	0.885	0.895	3	Halogenation	\N
389	C-B coupling	12.2	54.6	0.8	0.94	17	C-X Transition Metal Coupling	\N
390	C-B Oxidation	51.925	59.575	0.88	0.92	2	Oxidation	\N
391	C-H Oxidation	23.2	23.2	0.82	0.82	1	Oxidation	\N
392	C-N coupling	32.125	141	0.6375	0.85	32	C-X Transition Metal Coupling	\N
393	C-O coupling	33.1	80.175	0.66	0.755	4	C-X Transition Metal Coupling	\N
394	Carbamate Formation	8	27.35	0.8	0.9275	8	Acyl Substitution	\N
395	Carbonate Formation	16.35	17.05	0.95	0.95	2	Acyl Substitution	\N
396	Carbonyl Oxidation	34.2	34.2	1	1	1	Oxidation	\N
397	Carbonyl Protection	20	34.85	0.92	0.945	4	Protection/Deprotection	\N
398	Carbonyl Reduction	18.9	95.45	0.8125	0.9625	40	Reduction	\N
399	Carboxylic Acid Activation	3.675	12.525	0.875	0.94	4	Acyl Substitution	\N
400	Chiral Auxiliary Cleavage	37.925	126.325	0.845	0.9375	8	Protection/Deprotection	\N
401	Chiral Auxiliary Installation	27.3	66.1	0.625	0.915	7	Protection/Deprotection	\N
402	Chlorodehydration	18.05	44.425	0.82	0.925	16	Halogenation	\N
403	Chromatography	714.95	8573.825	0.41	0.865	10	Other	\N
404	Condensation: Enamine Formation	7.825	16.15	0.76	0.9675	8	Carbonyl Chemistry	\N
405	Condensation: Imine Formation	10.6	24.1	0.9	0.94	17	Carbonyl Chemistry	\N
406	Condensation: Oxime/Hydrazone Formation	12.2	29	0.8	0.9	13	Carbonyl Chemistry	\N
407	Cope/Claisen Rearrangement	27.7	27.7	0.92	0.92	1	Rearrangement	\N
408	Curtius/Hofmann/Lossen/Schmidt Rearrangement	36.55	64.925	0.7325	0.865	10	Rearrangement	\N
409	Cyanation	69.6	101	0.72	0.89	9	C-C Transition Metal Coupling	\N
410	Cycloaddition	21.2	52.6	0.71	0.93	17	Ring Formation	\N
411	Cycloalkylation	26.65	58.5	0.725	0.905	7	Alkylation	\N
412	Cyclocondensation	26.25	63.475	0.6225	0.8875	42	Carbonyl Chemistry	\N
413	Decarboxylation	24.4	28.825	0.7875	0.9425	4	Rearrangement	\N
414	Dehydrogenation	50.625	53.975	0.8425	0.9	6	Oxidation	\N
415	Deoxygenation	26	124.925	0.8625	0.955	4	Reduction	\N
416	Deprotection	17.9	72.125	0.8425	0.95	90	Protection/Deprotection	\N
417	Diazotization	37.025	55.275	0.7575	0.7725	2	Oxidation	\N
418	Direct Arylation	67.85	96.45	0.62	0.745	7	C-C Transition Metal Coupling	\N
419	Displacement with CN or N3	17.5	58.3	0.6475	0.9475	7	Alkylation	\N
420	Electrophilic Aromatic Nitration	40.025	67.225	0.8	0.91	18	Aromatic Substitution	\N
421	Enol-Sulfonate/Enol-Phosphate/Enol-Silane Formation	8	8	0.7	0.7	1	Carbonyl Chemistry	\N
422	Epoxidation	20.05	40.25	0.915	0.98	3	Oxidation	\N
423	Ester Hydrolysis	15.2	68.375	0.79	0.96	42	Acyl Substitution	\N
424	Esterification	12.4	42	0.8575	0.96	29	Acyl Substitution	\N
425	Fischer Indole Synthesis	58.3	70.325	0.5525	0.6775	4	Rearrangement	\N
426	Fluorodehydration	35.3	90	0.62	0.79	9	Halogenation	\N
427	Form Conversion	21.075	43.75	0.8925	0.93	8	Other	\N
428	Friedel-Crafts Acylation	20.5	70.95	0.7375	0.8975	15	Aromatic Substitution	\N
429	Friedel-Crafts Alkylation	15.05	36.025	0.81	0.85	6	Aromatic Substitution	\N
430	Glycosylation	12.075	65.85	0.595	0.6925	4	Alkylation	\N
431	H-X Elimination	24.2	30.6	0.8575	0.8925	2	Other	\N
432	Halogen/Metal exchange	28.7	40.05	0.895	0.955	3	Other	\N
433	Horner-Wadsworth-Emmons Olefination	23.4	29.65	0.775	0.86	3	Carbonyl Chemistry	\N
434	Iododehydration	35.3	35.3	0.91	0.91	1	Halogenation	\N
435	Isomerization	19	24.8	0.88	0.9	5	Other	\N
436	Knoevenagel Condensation	7.425	19.5	0.91	0.97	6	Other	\N
437	Macrolactamization/Macrolactonization	35.4	52.2	0.9625	0.9875	2	Acyl Substitution	\N
438	Methylation	20.475	57.8	0.79	0.945	26	Alkylation	\N
439	Mitsunobu	35.9	198.7	0.64	0.82	7	Heteroatom Activation	\N
440	N-Oxidation	35.65	52.375	0.8225	0.925	8	Oxidation	\N
441	N-Protection	11	35.175	0.83	0.95	22	Protection/Deprotection	\N
442	NAS: Carbon Nucleophile	23.5	35.2	0.78	0.9	6	Aromatic Substitution	\N
443	NAS: Nitrogen Nucleophile	13.3	51.8	0.79	0.92	45	Aromatic Substitution	\N
444	NAS: Other Nucleophile	20.15	26.25	0.875	0.925	2	Aromatic Substitution	\N
445	NAS: Oxygen Nucleophile	17.9	53.2	0.77	0.95	25	Aromatic Substitution	\N
446	Negishi/Kumada	32.6	43.625	0.6275	0.865	8	C-C Transition Metal Coupling	\N
447	Nitrile Hydration	29.225	70.35	0.7925	0.95	10	Hydration/Dehydration	\N
448	Nitro Reduction	27.1	65.475	0.775	0.92	32	Reduction	\N
449	O-Protection	8.2	24.15	0.895	0.99	23	Protection/Deprotection	\N
450	Other	26	54	0.82	0.93	17	Other	\N
451	Other Acyl Substitution	10.55	35.1	0.845	0.975	18	Acyl Substitution	\N
452	Other Alkylation	15.6	46.2	0.71	0.92	61	Alkylation	\N
453	Other Aromatic Substitution	20.8	59.5	0.68	0.92	21	Aromatic Substitution	\N
454	Other C-C Transition Metal Coupling	20	59.1	0.64	0.91	21	C-C Transition Metal Coupling	\N
455	Other Carbonyl Chemistry	7.8	30.9	0.81	0.9	9	Carbonyl Chemistry	\N
456	Other Halogenation	16.4	16.4	0.9	0.9	1	Halogenation	\N
457	Other Heteroatom Activation	37.9	66.35	0.795	0.975	3	Heteroatom Activation	\N
458	Other Hydration/Dehydration	76.4	382.65	0.565	0.855	3	Hydration/Dehydration	\N
459	Other Metallation\n	6.375	8.325	0.9925	0.9975	2	Other	\N
460	Other Oxidation	45.5	90.5	0.7825	0.8675	2	Oxidation	\N
461	Other Protection	7.7	7.7	0.98	0.98	1	Protection/Deprotection	\N
462	Other Rearrangement	17.825	37.25	0.7625	0.875	10	Rearrangement	\N
463	Other Reduction	29.8	61.4	0.6975	0.88	20	Reduction	\N
464	Other Ring Formation	16.8	49.8	0.67	0.86	49	Ring Formation	\N
465	Oxidative Bromination	16.25	49.9	0.7525	0.9175	38	Halogenation	\N
466	Oxidative Chlorination	15.8	93.3	0.74	0.905	11	Halogenation	\N
467	Oxidative Cleavage	67.975	104.525	0.595	0.645	2	Oxidation	\N
468	Oxidative Fluorination	42.9	93.35	0.545	0.865	7	Halogenation	\N
469	Oxidative Iodination	17.2	31.7	0.83	0.95	19	Halogenation	\N
470	Phosphinylation/Phosphorylation	27.875	50.025	0.825	0.855	2	Heteroatom Activation	\N
471	RCM	392.075	809.65	0.805	1	4	C-C Transition Metal Coupling	\N
472	Recrystallization	15.2	33.9	0.8	0.95	85	Other	\N
473	Reductive Amination	22.8	91.2	0.705	0.85	27	Reduction	\N
474	Reductive Dehalogenation	59.55	65.85	0.715	0.805	2	Reduction	\N
475	Resolution: Catalytic	39.725	121.25	0.365	0.455	8	Other	\N
476	Resolution: Classical	25.8	84.95	0.35	0.43	19	Other	\N
477	Ring Contraction	38.5	38.5	0.71	0.71	1	Rearrangement	\N
478	Ring Expansion	47.3	47.3	0.9	0.9	1	Rearrangement	\N
479	S-Oxidation	25.9	71.1	0.71	0.84	9	Oxidation	\N
480	Salt Break	19.675	67.1	0.8125	0.99	14	Other	\N
481	Salt Formation	9	29.275	0.83	0.94	38	Other	\N
482	Sandmeyer Reaction	83.475	144.9	0.415	0.6875	4	Aromatic Substitution	\N
483	Solid-phase Peptide/Oligonucleotide Synthesis	1694.8	3264.2	0.7475	0.8425	2	Other	\N
484	Sonogashira	31.3	74.65	0.805	0.9	7	C-C Transition Metal Coupling	\N
485	Strecker	42.275	67.025	0.555	0.645	2	Carbonyl Chemistry	\N
486	Sulfinylation/Sulfonylation	13	38.3	0.84	0.95	25	Heteroatom Activation	\N
487	Suzuki	23.2	80	0.735	0.8925	37	C-C Transition Metal Coupling	\N
488	Telescope	38.8	100.5	0.6625	0.88	274	Other	\N
489	Transesterification	20.325	33.575	0.82	0.88	2	Acyl Substitution	\N
490	Urea Formation	12.4	55.45	0.86	0.905	11	Acyl Substitution	\N
491	Wittig Olefination	33.125	48.9	0.6775	0.895	10	Carbonyl Chemistry	\N
\.


--
-- Data for Name: bl_process_flowchart; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_process_flowchart (id, edge_id, flowchart_json) FROM stdin;
\.


--
-- Data for Name: bl_process_flowchart_history; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_process_flowchart_history (id, flowchart_json, version_no, create_time, creator, history_id, node_id) FROM stdin;
\.


--
-- Data for Name: bl_process_safety; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_process_safety (id, edge_id, safety_json, upload_file, file_list) FROM stdin;
\.


--
-- Data for Name: bl_project_group; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_project_group (id, project_id, acct_no, project_group_id) FROM stdin;
472	PROJECT_ID20250210616393029940678656	superadmin	PROJECT_GROUP_ID20250210616393030209114112
\.


--
-- Data for Name: bl_project_info; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_project_info (id, project_name, project_code, create_date, create_acct_no, extend, project_id, project_group_id, phase, admin_accounts) FROM stdin;
143	My_Draft	\N	2025-02-10 14:51:47.951	superadmin	\N	PROJECT_ID20250210616393029940678656	PROJECT_GROUP_ID20250210616393030209114112		["superadmin"]
\.


--
-- Data for Name: bl_reagent_column_order; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_reagent_column_order (id, reagent_name, column_order) FROM stdin;
\.


--
-- Data for Name: bl_reagent_data; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_reagent_data (id, reagent_name, reference_no, extend, creator, create_date, reagent_value, personal) FROM stdin;
\.


--
-- Data for Name: bl_route; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_route (id, route_id, route_name, project_id, create_date, creator, latest_route_id, extension_field, project_name, pmi, cost, update_user, update_date, status, phase) FROM stdin;
\.


--
-- Data for Name: bl_route_submission; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_route_submission (id, route_id, route_name, participant_role, update_date, remarks, status, submission_id, history_id, project_id, project_name, version_no, reason) FROM stdin;
\.


--
-- Data for Name: bl_sm_risk_assessment_info; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_sm_risk_assessment_info (id, route_id, json_info) FROM stdin;
\.


--
-- Data for Name: bl_user_feedback; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.bl_user_feedback (id, title, tag, content, acct_no, create_date, status, update_date, upload_attachment) FROM stdin;
\.


--
-- Data for Name: cm_app; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_app (id, acct_no, org_id, qr_code_path, apk_path, url, type, version_code) FROM stdin;
1	Guest	SYMBOL	lxprod:QR202006295056503983636480.jpg	lxprod:APP202006295056499684474880.jpg	http://apk.lxtech.com	android	1
\.


--
-- Data for Name: cm_application; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_application (app_no, app_code, app_name, app_type, management_type, app_desc, app_link, app_url_prefix, app_img, app_status, org_id, create_date, create_person, app_order, valid_period_start, valid_period_end) FROM stdin;
A20230131347802560303497216	Main	主系统	GENERAL	BOTH	\N	Duis et culpa	in	Release20230329368519491867287552.png	A	SYMBOL	2023-01-31 10:49:10	Guest	4	2023-01-30	2023-10-25
A20230619398167735621341184	iropa	IROPA	GENERAL	BOTH	[]	http://localhost:8080/iropa/#/home	iropa_		A	SYMBOL	2023-06-19 10:22:23.317	aries	0	2023-06-06	2025-07-13
\.


--
-- Data for Name: cm_application_related; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_application_related (app_no, related_no, related_type, related_status, org_id) FROM stdin;
A20230131347802560303497216	R20220127214147771584741376	Role	A	SYMBOL
A20230131347802560303497216	R20230505381955565140418560	Role	A	SYMBOL
A20230619398167735621341184	R20230825422576352725610496	Role	A	SYMBOL
A20230619398167735621341184	R20230825422576409361297408	Role	A	SYMBOL
A20230619398167735621341184	novartis	User	\N	SYMBOL
A20230619398167735621341184	webmaster	User	\N	SYMBOL
A20230619398167735621341184	 acct_test27 	User	\N	SYMBOL
A20230619398167735621341184	R20240326500002496931397632	Role	A	SYMBOL
A20230619398167735621341184	prod	User	\N	SYMBOL
A20230619398167735621341184	acct_test27	User	\N	SYMBOL
A20230619398167735621341184	isolation	User	\N	SYMBOL
A20230619398167735621341184	lingxi1	User	\N	SYMBOL
A20230619398167735621341184	location	User	\N	SYMBOL
A20230619398167735621341184	daisy	User	\N	SYMBOL
A20230619398167735621341184	Approve	User	\N	SYMBOL
A20230619398167735621341184	leader	User	\N	SYMBOL
A20230619398167735621341184	analysts	User	\N	SYMBOL
A20230619398167735621341184	test_lixiao	User	\N	SYMBOL
A20230619398167735621341184	mechanism	User	\N	SYMBOL
\.


--
-- Data for Name: cm_authority_data; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_authority_data (rs_no, rs_name, rs_type, rs_url, parent_no, rs_status, rs_desc, rs_order, org_id) FROM stdin;
CM:app:dictionary	获取数据字典	Data	/dictionary/option	CM:management:SystemConfig   	A	获取数据字典接口	0	SYMBOL
CM:app:download:apk:file	下载apk文件	Data	/app/down	CM:management:SystemConfig  	A	下载apk接口	0	SYMBOL
CM:app:upload:apk:file	上传apk文件	Data	/app/upload	CM:management:SystemConfig   	A	上传apk文件	0	SYMBOL
CM:app:version:code	获取系统最新版本号	Data	/app/version/code	CM:management:SystemConfig   	A	获取系统最新版本号接口	0	SYMBOL
CM:authority:delete	权限列表	Data	/authority/delete/	CM:settings:AuthorityManagement	A	权限删除接口	0	SYMBOL
CM:authority:info	权限详情	Data	/authority/info/	CM:settings:AuthorityManagement	A	权限详情接口	0	SYMBOL
CM:authority:save 	权限保存	Data	/authority/save	CM:settings:AuthorityManagement	A	权限保存接口	0	SYMBOL
CM:authority:update	权限修改	Data	/authority/update	CM:settings:AuthorityManagement	A	权限修改接口	0	SYMBOL
CM:CS:user:delete	用户删除(cs)	Data	/cs/user/delete/	CM:management:User	A	单用户删除接口	0	SYMBOL
CM:CS:user:department	部门用户信息查询(cs)	Data	/cs/user/in/departments	CM:management:User	A	部门用户信息查询(CS)	0	SYMBOL
CM:CS:user:detail 	用户详情(cs)	Data	/cs/user/detail	CM:management:User	A	用户详情信息接口（CS）	0	SYMBOL
CM:CS:user:info	用户附加详情(cs)	Data	/cs/user/info	CM:management:User	A	用户附加详情（CS）	0	SYMBOL
CM:CS:user:list:all 	用户列表（不分页）	Data	/cs/user/list/all	CM:management:User	A	用户列表接口（不分页）	0	SYMBOL
CM:CS:user:save 	用户新增（cs）	Data	/cs/user/save	CM:management:User	A	用户新增，包含附加信息（CS）	0	SYMBOL
CM:CS:user:update 	用户修改	Data	/cs/user/update	CM:management:User	A	用户修改，包含附加信息（CS）	0	SYMBOL
CM:departments:list	部门列表	Data	/dept/list/all	CM:management:Department	A	部门列表接口(不分也)	0	SYMBOL
CM:departments:search	查询部门名称	Data	/dept/name/query	CM:management:Department	A	根据部门编号查询部门名称	0	SYMBOL
CM:file:count	获取文件数目	Data	/file/count/	CM:management:File	A	获取文件数目接口	0	SYMBOL
CM:file:delete 	文件删除	Data	/file/remove	CM:management:File	A	删除单文件接口	0	SYMBOL
CM:file:delete:batch	删除多文件	Data	/file/batch/remove	CM:management:File	A	删除多文件接口	0	SYMBOL
CM:file:down	下载文件	Data	/file/down	CM:management:File	A	下载文件	0	SYMBOL
CM:file:image:show 	图片展示	Data	/file/image/show	CM:management:File	A	图片展示接口	0	SYMBOL
CM:file:list 	文件列表	Data	/file/list	CM:management:File	A	文件列表	0	SYMBOL
CM:file:reference 	交易参考号服务	Data	/file/reference	CM:management:File	A	交易参考号服务	0	SYMBOL
CM:file:upload	文件上传	Data	/file/upload	CM:management:File	A	文件上传接口	0	SYMBOL
CM:file:upload:multi	多文件上传	Data	/file/upload/multi	CM:management:File	A	多文件上传	0	SYMBOL
CM:management:Department	部门管理	Menu	\N	CM:SystemManagement  	A	用户部门管理	0	SYMBOL
CM:management:File	文件管理	Menu	\N	CM:SystemManagement 	A	文件管理	0	SYMBOL
CM:management:Role	角色管理	Menu	\N	CM:SystemManagement 	A	角色管理	0	SYMBOL
CM:management:SystemConfig 	系统配置	Menu	\N	CM:SystemManagement   	A	系统配置	0	SYMBOL
CM:management:User	用户管理	Menu	\N	CM:SystemManagement	A	用户管理	0	SYMBOL
CM:role:delete	角色删除	Data	/role/delete	CM:management:Role	A	角色删除接口	0	SYMBOL
CM:role:info	角色详情	Data	/role/info	CM:management:Role	A	角色详情接口	0	SYMBOL
CM:role:list	角色列表(不分页)	Data	/role/list	CM:management:Role	A	角色列表信息	0	SYMBOL
CM:role:save	角色新增	Data	/role/save	CM:management:Role	A	角色新增接口	0	SYMBOL
CM:role:update 	角色修改	Data	/role/update	CM:management:Role	A	角色修改接口	0	SYMBOL
CM:settings:AuthorityManagement	权限管理	Menu	\N	CM:SystemSettings  	A	系统权限设置	0	SYMBOL
CM:SystemManagement	系统管理	Menu	\N	userAuthServer	A	系统公共管理	0	SYMBOL
CM:SystemSettings	系统设置	Menu	\N	userAuthServer	A	系统用户公共设置	0	SYMBOL
CM:user:department:batch	批量获取用户下部门	Data	/user/info/departments	CM:management:User	A	批量获取用户部门接口	0	SYMBOL
CM:user:department:list	部门下用户	Data	/user/in/departments	CM:management:User	A	获取部门下所有用户信息接口	0	SYMBOL
CM:user:list	用户列表(分页)	Data	/user/list	CM:management:User	A	用户列表接口（含分页）	0	SYMBOL
integratedServer	业务服务	Menu	\N	SystemRoot	A	业务服务	0	SYMBOL
NGS:SystemManagement 	NGS系统管理	Menu	\N	integratedServer	A	NGS系统管理	0	SYMBOL
SystemRoot	系统根节点	Menu	\N	~	A	系统根节点	0	SYMBOL
userAuthServer	用户服务	Menu	\N	SystemRoot	A	用户微服务	0	SYMBOL
\.


--
-- Data for Name: cm_authority_exempt; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_authority_exempt (rs_no, org_id, role_no) FROM stdin;
allDepartmentList	SYMBOL	\N
allDepList	SYMBOL	\N
ApplicationDelete	SYMBOL	\N
ApplicationInfo	SYMBOL	\N
ApplicationList	SYMBOL	\N
ApplicationSave	SYMBOL	\N
ApplicationUpdate	SYMBOL	\N
authAll	SYMBOL	\N
authority-query	SYMBOL	\N
common:RoleDetail	SYMBOL	\N
CsUserDetail	SYMBOL	\N
DepartmentListAll	SYMBOL	\N
DictionaryInfo	SYMBOL	\N
FileBatchRemove	SYMBOL	\N
FileCount	SYMBOL	\N
FileDownload	SYMBOL	\N
FileImageShow	SYMBOL	\N
FileList	SYMBOL	\N
FileRemove	SYMBOL	\N
FileUpload	SYMBOL	\N
FileUploadMulti	SYMBOL	\N
GetAppVersionCode	SYMBOL	\N
GetDepartmentsOfUsers	SYMBOL	\N
GetDpNameByDpNo	SYMBOL	\N
GetUserListOfDepartments	SYMBOL	\N
ht:CsUserDetail	SYMBOL	\N
MutipleDictionaryInfo	SYMBOL	\N
ReferenceNo	SYMBOL	\N
RoleDetail	SYMBOL	\N
roleListAll	SYMBOL	\N
sso:CM:app:list:all	SYMBOL	\N
UploadApkFile	SYMBOL	\N
UserList	SYMBOL	\N
UserListAll	SYMBOL	\N
\.


--
-- Data for Name: cm_datasync_register; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_datasync_register (seq_no, app_name, app_location, register_date, create_date) FROM stdin;
\.


--
-- Data for Name: cm_datasync_task; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_datasync_task (app_name, source_table, target_table, target_database, primary_key, task_type, status) FROM stdin;
\.


--
-- Data for Name: cm_department_info; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_department_info (dp_no, dp_name, dp_type, parent_no, dp_status, dp_desc, dp_order, org_id, create_date) FROM stdin;
1	顶级部门	General	~	A	顶级部门	0	SYMBOL	2022-02-09
3	科技部	General	1	A	包括IT,研发，测试，BA，产品等	0	SYMBOL	2021-02-08
D2021020886262940323282944	科技部	General	1	A	包括IT,研发，测试，BA，产品等	0	SYMBOL	2021-02-08
D2021020886263069419765760	业务部	General	1	A	主要是销售	0	SYMBOL	2021-02-08
D20220209218895295239421952	fffff	General	1	A	fffff	0	SYMBOL	2022-02-09
D20220209218941288957870080	1212	General	1	A	2121	0	SYMBOL	2022-02-09
D20220210219141841428152320	农业部	General	1	A	农业部门描述	0	SYMBOL	2022-02-10
D20220210219166914692251648	采购部	General	1	A	采购部	0	SYMBOL	2022-02-10
\.


--
-- Data for Name: cm_file_upload; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_file_upload (seq_no, file_name, file_path, file_type, reference_no, create_date, original_file_name) FROM stdin;
\.


--
-- Data for Name: cm_file_upload_attach; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_file_upload_attach (seq_no, reference_no, file_name, original_file_name, org_id, creator, create_date, tran_date, module, status) FROM stdin;
\.


--
-- Data for Name: cm_menu; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_menu (menu_no, menu_name, menu_type, parent_no, menu_status, menu_order, org_id, resource_type, resource_name) FROM stdin;
BasicPlatformService	基础服务	View	SystemRoot	B	0	SYMBOL	\N	\N
CM:application	应用管理	View	BasicPlatformService	A	0	SYMBOL	\N	\N
CM:application:all	全部	Data	CM:application	A	0	SYMBOL	Controller	CmApplicationController
CM:department	部门管理	View	BasicPlatformService	A	0	SYMBOL	\N	\N
CM:department:list	列表	Data	CM:department	A	0	SYMBOL	AuthorityName	CmDepartmentController:list
CM:department:operation	操作	Data	CM:department	A	0	SYMBOL	Group	dep-operation
CM:file	文件管理	View	BasicPlatformService	A	0	SYMBOL	\N	\N
CM:file:operation	操作	Data	CM:file	A	0	SYMBOL	Group	file-operation
CM:file:view	显示	Data	CM:file	A	0	SYMBOL	Group	file-view
CM:resources	资源管理	View	BasicPlatformService	A	0	SYMBOL	\N	\N
CM:resources:all	全部	Data	CM:resources	A	0	SYMBOL	Controller	CmResourcesController
CM:role	角色管理	View	BasicPlatformService	A	0	SYMBOL	\N	\N
CM:role:list	列表	Data	CM:role	A	0	SYMBOL	AuthorityName	CmRoleController:list
CM:role:operation	操作	Data	CM:role	A	0	SYMBOL	Group	role-operation
CM:user	用户管理	View	BasicPlatformService	A	0	SYMBOL	\N	\N
CM:user:list	列表	Data	CM:user	A	0	SYMBOL	AuthorityName	
CM:user:operation	操作	Data	CM:user	A	0	SYMBOL	Group	user-operation
Main:application	主系统管理	View	SystemRoot	A	1	SYMBOL	\N	\N
Main:application:Application Management	Application Management	View	Main:application	A	0	SYMBOL	\N	\N
Main:application:Release Management	Release Management	Data	Main:application	A	0	SYMBOL	Group	ReleseInfo-operation
Main:application:Role Management	Role Management	Data	Main:application	A	0	SYMBOL	Group	SysAll-operation
Main:application:User Management	User Management	View	Main:application	A	0	SYMBOL	Group	SysAll-operation
Main:Home	Home	View	SystemRoot	A	0	SYMBOL	\N	\N
Public:System Management	System Management	View	SystemRoot	A	2	SYMBOL	Group	\N
iropa:Route Management:Route Search	Route Search	Data	iropa:Route Management	A	0	SYMBOL	Group	RouteAll-operation
Public:Constants Setting	Constants Setting	Data	Public:System Management	A	3	SYMBOL	Group	\N
Public:Role Management,addRole	Role Management	Data	Public:System Management	A	1	SYMBOL	Group	SysAll-operation
iropa:Route Management	Route Management	View	SystemRoot	A	1	SYMBOL	\N	\N
iropa:Route Management:Route Search:versionManagement	Version Management	Data	iropa:Route Management	A	0	SYMBOL	Group	RouteAll-operation
iropa:Route Management:Route Search:routeComparison	Route Comparison	Data	iropa:Route Management	A	0	SYMBOL	Group	RouteAll-operation
Public:User Management,addUser	User Management	Data	Public:System Management	A	2	SYMBOL	Group	SysAll-operation
Tools:data-import:hist:all	Import	Data	iropa:Data Management:Reagent Management:addReagent	A	0	SYMBOL	Controller	DataImportHistController
iropa:Data Management:Reagent Management:addReagent	Reagent Management	Data	Public:System Management	A	0	SYMBOL	Group	ReagentAll-operation
iropa:Data Management:Project Management:addProject	Project Management	Data	Public:System Management	A	0	SYMBOL	Group	ProjectAll-operation
iropa:Route Management:Route Desktop	Route Desktop	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
iropa:Data Management	Data Management	View	SystemRoot	B	1	SYMBOL	\N	\N
iropa:Route Desktop:SM Risk Assessment	SM Risk Assessment	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
iropa:Search System:Intermediate Search	Intermediate Search	Data	iropa:Search System	A	1	SYMBOL	Group	RouteAll-operation
Public:Feedback Management	Feedback Management	Data	Public:System Management	A	3	SYMBOL	Group	SysAll-operation
iropa:Route Desktop:Material Cost	Material Cost	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
iropa:Route Desktop:Environmental Sustainability	Environmental Sustainability	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
iropa:Search System:Project Search	Project Search	Data	iropa:Search System	A	1	SYMBOL	Group	RouteAll-operation
iropa:Search System	Search System	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
iropa:Star system	Star system	Data	SystemRoot	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Platform Request	Platform Request	Data	iropa:Star system	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Platform Chart	Platform Chart	Data	iropa:Star system	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Analytical Request	Analytical Request	Data	iropa:Star system	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Platform Request:Add New Request	Add New Request	Data	iropa:Star system:Platform Request	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Platform Request:Fill In Result	Fill In Result	Data	iropa:Star system:Platform Request	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Analytical Request:Add New Request	Add New Request	Data	iropa:Star system:Analytical Request	A	1	SYMBOL	Group	Star-operation
iropa:Star system:Analytical Request:Fill In Result	Fill In Result	Data	iropa:Star system:Analytical Request	A	1	SYMBOL	Group	Star-operation
iropa:Route Desktop:File System	File System	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
iropa:Route Desktop:Sensitivity Analysis	Sensitivity Analysis	Data	iropa:Route Management	A	1	SYMBOL	Group	RouteAll-operation
\.


--
-- Data for Name: cm_resources_list; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_resources_list (seq_no, rl_no, rs_no, rs_type, rs_target, description, status, org_id) FROM stdin;
1	RS2021020886264578312241152	order-type-01	tech	A	订单销售	A	SYMBOL
2	RS2021020886264642250211328	order-type-01	tech	B	订单售后	A	SYMBOL
3	RS2021020886264684117753856	order-type-01	tech	C	订单物流	A	SYMBOL
4	RS2021020886264774513393664	order-type-02	tech	D	订单评论	A	SYMBOL
\.


--
-- Data for Name: cm_role_authority; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_role_authority (role_no, rs_no, rs_type, org_id) FROM stdin;
R20220127214147771584741376	Main:Home	Menu	SYMBOL
R20230505381955565140418560	Main:Home	Menu	SYMBOL
R20230505381955565140418560	Main:application:Application Management	Menu	SYMBOL
R20240326500002496931397632	iropa:Route Management:Route Search	Menu	SYMBOL
R20240326500002496931397632	iropa:Route Management:Route Search:versionManagement	Menu	SYMBOL
R20240326500002496931397632	iropa:Route Management:Route Search:routeComparison	Menu	SYMBOL
R20240326500002496931397632	iropa:Route Management:Route Desktop	Menu	SYMBOL
R20240326500002496931397632	iropa:Route Desktop:Material Cost	Menu	SYMBOL
R20240326500002496931397632	iropa:Route Desktop:Environmental Sustainability	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Management	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Management:Route Search	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Management:Route Search:versionManagement	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Management:Route Search:routeComparison	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Management:Route Desktop	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Desktop:SM Risk Assessment	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Desktop:Material Cost	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Desktop:Environmental Sustainability	Menu	SYMBOL
R20230825422576409361297408	iropa:Search System	Menu	SYMBOL
R20230825422576409361297408	iropa:Search System:Intermediate Search	Menu	SYMBOL
R20230825422576409361297408	iropa:Search System:Project Search	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Desktop:File System	Menu	SYMBOL
R20230825422576409361297408	iropa:Route Desktop:Sensitivity Analysis	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Platform Request	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Platform Request:Add New Request	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Platform Request:Fill In Result	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Platform Chart	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Analytical Request	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Analytical Request:Add New Request	Menu	SYMBOL
R20230825422576409361297408	iropa:Star system:Analytical Request:Fill In Result	Menu	SYMBOL
R20230825422576409361297408	iropa:Data Management:Reagent Management:addReagent	Menu	SYMBOL
R20230825422576409361297408	Tools:data-import:hist:all	Menu	SYMBOL
R20230825422576409361297408	iropa:Data Management:Project Management:addProject	Menu	SYMBOL
R20230825422576409361297408	Public:Feedback Management	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Management	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Management:Route Search	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Management:Route Search:versionManagement	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Management:Route Search:routeComparison	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Management:Route Desktop	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Desktop:SM Risk Assessment	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Desktop:Material Cost	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Desktop:Environmental Sustainability	Menu	SYMBOL
R20230825422576352725610496	iropa:Search System	Menu	SYMBOL
R20230825422576352725610496	iropa:Search System:Intermediate Search	Menu	SYMBOL
R20230825422576352725610496	iropa:Search System:Project Search	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Desktop:File System	Menu	SYMBOL
R20230825422576352725610496	iropa:Route Desktop:Sensitivity Analysis	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Platform Request	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Platform Request:Add New Request	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Platform Request:Fill In Result	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Platform Chart	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Analytical Request	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Analytical Request:Add New Request	Menu	SYMBOL
R20230825422576352725610496	iropa:Star system:Analytical Request:Fill In Result	Menu	SYMBOL
R20230825422576352725610496	Public:System Management	Menu	SYMBOL
R20230825422576352725610496	iropa:Data Management:Reagent Management:addReagent	Menu	SYMBOL
R20230825422576352725610496	Tools:data-import:hist:all	Menu	SYMBOL
R20230825422576352725610496	iropa:Data Management:Project Management:addProject	Menu	SYMBOL
R20230825422576352725610496	Public:Role Management,addRole	Menu	SYMBOL
R20230825422576352725610496	Public:User Management,addUser	Menu	SYMBOL
R20230825422576352725610496	Public:Constants Setting	Menu	SYMBOL
R20230825422576352725610496	Public:Feedback Management	Menu	SYMBOL
\.


--
-- Data for Name: cm_role_info; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_role_info (seq_no, role_no, role_name, role_type, parent_no, org_id, create_date) FROM stdin;
46	R20230505381955565140418560	默认主系统	Menu	~	SYMBOL	2023-05-05
20	R20240326500002496931397632	Analyst	Menu	~	SYMBOL	2024-03-26
17	R20230825422576409361297408	General User	Menu	~	SYMBOL	2023-08-25
16	R20230825422576352725610496	Admin	Menu	~	SYMBOL	2023-08-25
\.


--
-- Data for Name: cm_system; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_system (seq_no, sys_code, sys_name, org_id, syst_host, auth_mode, auth_type, sys_status, start_date) FROM stdin;
1	SYMBOL	核心业务系统	SYMBOL	127.0.0.1	URL	Menu	A	2018-11-15
\.


--
-- Data for Name: cm_user_department; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_user_department (acct_no, org_id, dp_no) FROM stdin;
\.


--
-- Data for Name: cm_user_info; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_user_info (seq_no, acct_no, acct_pwd, user_name, org_id, user_type, user_category, user_status, create_date, extension_field) FROM stdin;
1	superadmin	$2a$10$KAAJHWyGxYouuDsMY5ASPONwYDAmW/1Xi/NohhTzG67Q/sHfxQd7y	superadmin	SYMBOL	Admin	GENERAL	A	2018-04-02	{"name": "", "email": "admin@qq.com"}
97	webmaster	$2a$10$EZ7HI6FUocG.8yVFWgXkYOd1u6O3oJpNkfgYK6bxHCvumYGwIVK7y	webmaster	SYMBOL	User	\N	A	2023-08-25	{"name": "Z", "email": "webmaster@qq.com", "homeAddress": "Switzerland"}
96	novartis	$2a$10$tFIgFIKpDWYKb9XPXXGH4.CN6NilNoLcoicLY3Zg6t2UB/weuToTa	novartis	SYMBOL	User	\N	A	2023-08-25	{"name": "Z", "email": "novartis@qq.com", "homeAddress": "Anguilla"}
\.


--
-- Data for Name: cm_user_openid; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_user_openid (seq_no, acct_no, open_id, open_type, org_id, create_date) FROM stdin;
2	aries	13609165743	mobile	SYMBOL	2020-08-11
3	aries	oPE0S5YRwEN1MSU8DPLlv0FWffqQ	weixin	SYMBOL	2020-08-11
5	aries	aries-openid	openID	SYMBOL	2020-08-11
7	test	0716d13f987fbffcc456edb157500b98	visitorID	SYMBOL	2022-04-16
8	aries	d7655547fb5c11dd9446e198065c34e6	visitorID	SYMBOL	2022-04-26
\.


--
-- Data for Name: cm_user_role; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cm_user_role (acct_no, role_no, org_id) FROM stdin;
novartis	R20230825422576409361297408	SYMBOL
webmaster	R20230825422576352725610496	SYMBOL
prod	R20230825422576352725610496	SYMBOL
isolation	R20230825422576409361297408	SYMBOL
lingxi1	R20230825422576409361297408	SYMBOL
location	R20230825422576409361297408	SYMBOL
daisy	R20230825422576409361297408	SYMBOL
Approve	R20230825422576409361297408	SYMBOL
leader	R20240628534137402350837760	SYMBOL
analysts	R20240326500002496931397632	SYMBOL
test_lixiao	R20240628534137402350837760	SYMBOL
mechanism	R20230825422576352725610496	SYMBOL
\.


--
-- Data for Name: cs_category; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cs_category (seq_no, category_code, category_name, status, org_id) FROM stdin;
260	Category	Category	true	SYMBOL
6	Phase	Phase	true	SYMBOL
5	SM Attribute	SM Attribute	true	SYMBOL
300	Platform Request: Transfer To Basel	Platform Request: Transfer To Basel	true	SYMBOL
301	Platform Request: Enable	Platform Request: Enable	true	SYMBOL
302	Platform Request: Supply	Platform Request: Supply	true	SYMBOL
303	Platform Request: Validation	Platform Request: Validation	true	SYMBOL
304	Platform Request: Hit	Platform Request: Hit	true	SYMBOL
305	Platform Request: Platform	Platform Request: Platform	true	SYMBOL
306	Platform Request: Status	Platform Request: Status	true	SYMBOL
307	Platform Request: Reaction Type	Platform Request: Reaction Type	true	SYMBOL
313	Platform Request Authorized Users	Platform Request Authorized Users	true	SYMBOL
314	Platform Request: Research Type	Platform Request: Research Type	true	SYMBOL
18	Analytical Request: Scientists for MS Task Assignment	Scientists for MS Task Assignment	true	SYMBOL
19	Analytical Request: Scientists for NMR Task Assignment	Scientists for NMR Task Assignment	true	SYMBOL
20	Analytical Request: Scientists for Report Final Task Assignment	Scientists for Report Final Task Assignment	true	SYMBOL
22	Analytical Request: The Authorized Users for Mechanism Task Assignment	Scientists for Mechanism Task Assignment	true	SYMBOL
310	Analytical Request: Impurity Source	Impurity Source	true	SYMBOL
309	Analytical Request: Classification	Classification	true	SYMBOL
308	Analytical Request: Assign Task: Status	Assign Task: Status	true	SYMBOL
23	Analytical Request: Scientists for Sample Management Task Assignment	Scientists for Sample Management Task Assignment	true	SYMBOL
21	Analytical Request: Team Leader	Team Leader	true	SYMBOL
17	Analytical Request: Scientists for Isolation Task Assignment	Scientists for Isolation Task Assignment	true	SYMBOL
25	Analytical Request: Scientists for Single Crystal Task Assignment	Scientists for Single Crystal Task Assignment	true	SYMBOL
26	Analytical Request: Scientists for Single Crystal Task Assignment	Scientists for Single Crystal Task Assignment	true	SYMBOL
11	Impurity Profile: Acquired From	Acquired From	true	SYMBOL
12	Impurity Profile: Category	Category	true	SYMBOL
14	Impurity Profile: CSI Status	CSI Status	true	SYMBOL
15	Impurity Profile: Method	Method	true	SYMBOL
27	Environmental Sustainability Submission: Reviewer	Reviewer	true	SYMBOL
4	Reagent Attribute	Reagent Attribute	true	SYMBOL
\.


--
-- Data for Name: cs_dictionary; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cs_dictionary (seq_no, category_seq_no, dictionary_code, dictionary_name, order_num, status, org_id, extension_field) FROM stdin;
13	5	API-SM	API-SM	1	true	SYMBOL	{"describe":"","color":"#FF4268"}
12	5	Starting material	Starting material	2	true	SYMBOL	{"describe":"","color":"#A540FE"}
14	5	Custom manufactured	Custom manufactured	3	true	SYMBOL	{"describe":"","color":"#02C0FE"}
15	5	Off-the-shelf	Off-the-shelf	4	true	SYMBOL	{"describe":"","color":"#3FEADD"}
20	5	IP-1	IP-1	5	true	SYMBOL	{"describe":"","color":"#FCD1F3"}
30	5	IP	IP	6	true	SYMBOL	{"describe":"","color":"#7AD2C1"}
48	5	DS	DS	7	true	SYMBOL	{"describe":"","color":"#E7F21D"}
8	260	NON-GMP	NON-GMP	1	true	SYMBOL	{"describe":"","color":"#A2AAAD"}
7	260	GMP	GMP	2	true	SYMBOL	{"describe":"","color":"#F39801"}
84	6	Early Dev	Early Dev	1	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
23	6	Late Dev	Late Dev	2	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
24	6	Commercial	Commercial	3	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
22	6	Ph1Re	Ph1Re	4	true	SYMBOL	{"describe":"","color":"","dictionariesList":[{"dictionaryCode":"Ph1R1","dictionaryName":"Ph1R1","describe":"","color":"","extensionField":"{\\"describe\\":\\"\\",\\"color\\":\\"\\",\\"dictionariesList\\":[]}"},{"dictionaryCode":"Ph1R2","dictionaryName":"Ph1R2","describe":"","color":"","extensionField":"{\\"describe\\":\\"\\",\\"color\\":\\"\\",\\"dictionariesList\\":[]}"}]}
80	6	PAC	PAC	5	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
81	6	PC	PC	6	true	SYMBOL	{"describe":"","color":"","dictionariesList":[{"dictionaryCode":"PC1","dictionaryName":"PC1","describe":"","color":"","extensionField":"{\\"describe\\":\\"\\",\\"color\\":\\"\\",\\"dictionariesList\\":[]}"}]}
82	6	PAC demo	PAC demo	7	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
83	6	Launch	Launch	8	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
85	6	Final Synthesis	Final Synthesis	9	true	SYMBOL	{"describe":"","color":"","dictionariesList":[]}
90	306	to be Started	to be Started	1	true	SYMBOL	{"describe":"","color":""}
91	306	Ongoing	Ongoing	2	true	SYMBOL	{"describe":"","color":""}
92	306	Finished	Finished	3	true	SYMBOL	{"describe":"","color":""}
93	306	Cancel	Cancel	4	true	SYMBOL	{"describe":"","color":""}
94	305	Chemistry in Water	Chemistry in Water	6	true	SYMBOL	{"describe":"","color":""}
95	305	Global Catalysis	Global Catalysis	1	true	SYMBOL	{"describe":"","color":""}
96	305	CM	CM	2	true	SYMBOL	{"describe":"","color":""}
97	305	PAT	PAT	3	true	SYMBOL	{"describe":"","color":""}
98	305	Bio-Catalysis	Bio-Catalysis	4	true	SYMBOL	{"describe":"","color":""}
99	305	CEN	CEN	5	true	SYMBOL	{"describe":"","color":""}
100	305	Photo-Chemistry	Photo-Chemistry	7	true	SYMBOL	{"describe":"","color":""}
101	305	Electro-Chemistry	Electro-Chemistry	8	true	SYMBOL	{"describe":"","color":""}
102	314	Type 2	Type 2	2	true	SYMBOL	{"describe":"","color":""}
103	314	Type 1	Type 1	1	true	SYMBOL	{"describe":"","color":""}
104	304	No	No	2	true	SYMBOL	{"describe":"","color":""}
105	304	NA	NA	3	true	SYMBOL	{"describe":"","color":""}
106	304	Yes	Yes	1	true	SYMBOL	{"describe":"","color":""}
107	303	NA	NA	3	true	SYMBOL	{"describe":"","color":""}
108	303	Yes	Yes	1	true	SYMBOL	{"describe":"","color":""}
109	303	No	No	2	true	SYMBOL	{"describe":"","color":""}
110	302	NA	NA	3	true	SYMBOL	{"describe":"","color":""}
111	302	No	No	2	true	SYMBOL	{"describe":"","color":""}
112	302	Yes	Yes	1	true	SYMBOL	{"describe":"","color":""}
113	301	No	No	2	true	SYMBOL	{"describe":"","color":""}
114	301	Yes	Yes	1	true	SYMBOL	{"describe":"","color":""}
115	301	NA	NA	3	true	SYMBOL	{"describe":"","color":""}
116	300	NA	NA	3	true	SYMBOL	{"describe":"","color":""}
117	300	No	No	2	true	SYMBOL	{"describe":"","color":""}
118	300	Yes	Yes	1	true	SYMBOL	{"describe":"","color":""}
119	310	Commercial purchased	Commercial purchased	1	true	SYMBOL	{"describe":"","color":""}
120	310	In-house lsolation	In-house lsolation	4	true	SYMBOL	{"describe":"","color":""}
121	310	Outsourced lsolation	Outsourced lsolation	3	true	SYMBOL	{"describe":"","color":""}
122	310	Synthesized	Synthesized	2	true	SYMBOL	{"describe":"","color":""}
123	309	ldentification	ldentification	2	true	SYMBOL	{"describe":"","color":""}
124	309	Confirmation	Confirmation	1	true	SYMBOL	{"describe":"","color":""}
125	308	Finished	Finished	1	true	SYMBOL	{"describe":"","color":""}
126	308	On hold	On hold	6	true	SYMBOL	{"describe":"","color":""}
127	308	no need	no need	5	true	SYMBOL	{"describe":"","color":""}
128	308	Pending	Pending	4	true	SYMBOL	{"describe":"","color":""}
129	308	Cancelled	Cancelled	3	true	SYMBOL	{"describe":"","color":""}
130	308	Ongoing	Ongoing	2	true	SYMBOL	{"describe":"","color":""}
131	21	webmaster	webmaster	1	true	SYMBOL	{"describe":"","color":""}
132	17	webmaster	webmaster	1	true	SYMBOL	{"describe":"","color":""}
133	12	Actual	Actual	1	true	SYMBOL	{"describe":"","color":""}
134	12	Potential	Potential	2	true	SYMBOL	{"describe":"","color":""}
135	12	Fate	Fate	3	true	SYMBOL	{"describe":"","color":""}
136	12	Mutagenic	Mutagenic	4	true	SYMBOL	{"describe":"","color":""}
137	12	Cohort of concern	Cohort of concern	5	true	SYMBOL	{"describe":"","color":""}
138	\N	Four Task	\N	\N	\N	\N	\N
139	\N	Impurity Profile One Task	\N	\N	\N	\N	\N
140	27	novartis	novartis	1	true	SYMBOL	{"describe":"","color":""}
141	\N	Five Task	\N	\N	\N	\N	\N
142	\N	Supplementary Information Task	\N	\N	\N	\N	\N
5	4	Solvents	Solvents	1	true	SYMBOL	{"describe":"","color":""}
66	4	Reagent	Reagent	2	true	SYMBOL	{"describe":"","color":""}
67	4	Catalytic	Catalytic	3	true	SYMBOL	{"describe":"","color":""}
\.


--
-- Data for Name: cs_user_info; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.cs_user_info (seq_no, acct_no, org_id, info) FROM stdin;
1	aries	SYMBOL	[{"isLeader": ""}, {"cellphone": "1360956587"}, {"agent": ""}]
2	test	SYMBOL	[{"isLeader": ""}, {"cellphone": ""}, {}]
\.


--
-- Data for Name: data_etl_hist; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.data_etl_hist (reference_no, description, data_reader, data_writer, field_mapping, split_pk, batch_num, reader_object_name, writer_object_name, incremental, start_reference, status, run_date, information, creator, create_date) FROM stdin;
\.


--
-- Data for Name: data_import_hist; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.data_import_hist (reference_no, rule_name, file_name, file_reference, description, file_path, field_mapping, is_check_name, data_path, status, creator, create_date) FROM stdin;
\.


--
-- Data for Name: data_import_rule; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.data_import_rule (rule_name, file_type, mode, description, table_column, target_table, ignore_column, excute_bean_name, es_data_service, delimiter, incremental, batch_flag, commit_num) FROM stdin;
Reagent-Import	Csv	File	Reagent导入	[]	bl_reagent_data	["id","create_date"]	reagentImportProcessingImpl	No	NA	Yes	Yes	2000
\.


--
-- Data for Name: process_reactor_list; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.process_reactor_list (size, cost_rate_cny, cost_rate_usd, label, id) FROM stdin;
500	3500	21.00	scenarioA	1
1000	3500	21.00	scenarioA	2
2000	4500	27.00	scenarioA	3
3000	4500	27.00	scenarioA	4
5000	5000	30.00	scenarioA	5
6300	5000	30.00	scenarioA	6
8000	5500	33.00	scenarioA	7
10000	5500	33.00	scenarioA	8
16000	6000	36.00	scenarioA	9
\.


--
-- Data for Name: process_selection; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.process_selection (id, history_id, node_id, step_name, weight_sm, weight_sp, step_pmi, reaction_type, hydrogenation, reactor, volume, reactor_size, batch_number_a, hour_per_batch, cost_per_hour_a, cost_per_hour_b, material_cost, ecology_cost, factor, step_process_cost_a, step_process_cost_b, total_a, total_b, source, gmp, order_num, different_fields, cost_per_hour_size, batch_number, cost_per_hour_c, step_process_cost_c, total_c, reactor_size_a, mean) FROM stdin;
\.


--
-- Data for Name: st_analytical_assign_task; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_assign_task (id, analytical_id, name, scientist, status, review_status, comments, effective_status, assign_task_file, create_time, creator, modify_time, modifier, receive_date, return_date) FROM stdin;
\.


--
-- Data for Name: st_analytical_basic; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_basic (id, sir_no, request_date, requester, project, campaign, step, imp_identifier, batch_no, choose_request, time_sheet, basic_file, create_time, creator, modify_time, modifier, smiles_code, structure_edit, review_status, nvp_code, route_id, node_id, impurity_id, batch_id, chromeleon_add) FROM stdin;
\.


--
-- Data for Name: st_analytical_investigation; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_investigation (id, analytical_id, impurity_source, classification, lc_ms, nmr) FROM stdin;
\.


--
-- Data for Name: st_analytical_isolation; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_isolation (id, analytical_id, campaign, step, sample_appearance, sample_amount, content, imp_level, suggested_solvent, solubility, rrt, impurity_amount, exact_mass, dose_unit) FROM stdin;
\.


--
-- Data for Name: st_analytical_merge_log; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_merge_log (id, analytical_id, sir_no, file_no, version_no, create_time, creator) FROM stdin;
\.


--
-- Data for Name: st_analytical_registration; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_registration (id, analytical_id, analyst, start_date, method_optimization, method_time, injection_number, total_collection_time, rotary_evaporation, freeze_drying, ms_confirmation, net_cost_time, deliver_date, cycle_time, year, impurity_amount, recovery, create_time, creator, modify_time, modifier) FROM stdin;
\.


--
-- Data for Name: st_analytical_word_template; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_analytical_word_template (id, name, content, file_no) FROM stdin;
\.


--
-- Data for Name: st_platform_request; Type: TABLE DATA; Schema: public; Owner: lx_iropa
--

COPY public.st_platform_request (platform_request_id, project_no, research_type, submit_time, expected_deadline, time_card, contact_person, phase, analyst_if_needed, reaction_type, project_lead, platform, original_result, expectation, create_time, creator, modify_time, modifier, chemist_from_platform, end_time, status, hit, validation, supply, enable, transfer_to_basel, final_result, supplied_information, comments, upload_file, online_info, smiles_step, smiles_result, reaction_scheme, file_name) FROM stdin;
\.


--
-- Name: batch_job_log_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.batch_job_log_seq_no_seq', 1, false);


--
-- Name: bl_chemicals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_chemicals_id_seq', 392198, true);


--
-- Name: bl_chemicals_manufacture_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_chemicals_manufacture_id_seq', 12, true);


--
-- Name: bl_cost_material_montitoring_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_cost_material_montitoring_id_seq', 1687, true);


--
-- Name: bl_cost_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_cost_module_id_seq', 50, true);


--
-- Name: bl_cost_process_planing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_cost_process_planing_id_seq', 2490, true);


--
-- Name: bl_edge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_edge_id_seq', 128924, true);


--
-- Name: bl_edge_manufacture_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_edge_manufacture_seq', 1, true);


--
-- Name: bl_es_report_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_es_report_seq', 1, false);


--
-- Name: bl_history_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_history_id_seq', 984, true);


--
-- Name: bl_impurity_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_impurity_profile_id_seq', 14924, true);


--
-- Name: bl_node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_node_id_seq', 143265, true);


--
-- Name: bl_preset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_preset_id_seq', 493, true);


--
-- Name: bl_process_flowchart_history_id; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_process_flowchart_history_id', 1, true);


--
-- Name: bl_process_flowchart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_process_flowchart_id_seq', 13179, true);


--
-- Name: bl_process_safety_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_process_safety_id_seq', 4961, true);


--
-- Name: bl_project_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_project_group_id_seq', 472, true);


--
-- Name: bl_project_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_project_info_id_seq', 143, true);


--
-- Name: bl_reagent_column_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_reagent_column_order_id_seq', 13, true);


--
-- Name: bl_reagent_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_reagent_data_id_seq', 5185, true);


--
-- Name: bl_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_route_id_seq', 895, true);


--
-- Name: bl_route_submission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_route_submission_id_seq', 2, true);


--
-- Name: bl_sm_risk_assessment_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_sm_risk_assessment_info_id_seq', 71, true);


--
-- Name: bl_user_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.bl_user_feedback_id_seq', 21, true);


--
-- Name: cm_app_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_app_id_seq', 2, false);


--
-- Name: cm_app_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_app_seq_no_seq', 1, false);


--
-- Name: cm_datasync_register_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_datasync_register_seq_no_seq', 1, false);


--
-- Name: cm_datasync_task_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_datasync_task_seq_no_seq', 1, false);


--
-- Name: cm_file_upload_attach_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_file_upload_attach_seq_no_seq', 1, false);


--
-- Name: cm_file_upload_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_file_upload_seq_no_seq', 1, false);


--
-- Name: cm_resources_list_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_resources_list_seq_no_seq', 1, false);


--
-- Name: cm_role_info_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_role_info_seq_no_seq', 1, false);


--
-- Name: cm_user_info_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_user_info_seq_no_seq', 2, false);


--
-- Name: cm_user_openid_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cm_user_openid_seq_no_seq', 1, false);


--
-- Name: cmlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cmlog_id_seq', 6, false);


--
-- Name: cs_category_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cs_category_seq_no_seq', 1, false);


--
-- Name: cs_dictionary_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cs_dictionary_seq_no_seq', 1, false);


--
-- Name: cs_user_info_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cs_user_info_seq_no_seq', 1, false);


--
-- Name: cutoff_id; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.cutoff_id', 6, false);


--
-- Name: experimental_data_id; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.experimental_data_id', 6, false);


--
-- Name: experimental_source_data_compound_id; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.experimental_source_data_compound_id', 6, false);


--
-- Name: experimental_source_data_id; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.experimental_source_data_id', 6, false);


--
-- Name: experimental_user_config_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.experimental_user_config_id_seq', 6, false);


--
-- Name: id_auto_incr; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.id_auto_incr', 6, false);


--
-- Name: id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.id_seq', 6, false);


--
-- Name: process_reactor_list_id; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.process_reactor_list_id', 9, true);


--
-- Name: process_selection_seq_no; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.process_selection_seq_no', 634, true);


--
-- Name: st_analytical_assign_task_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_assign_task_id_seq', 14, true);


--
-- Name: st_analytical_basic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_basic_id_seq', 4, true);


--
-- Name: st_analytical_investigation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_investigation_id_seq', 1, true);


--
-- Name: st_analytical_isolation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_isolation_id_seq', 1, true);


--
-- Name: st_analytical_merge_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_merge_id_seq', 1, true);


--
-- Name: st_analytical_registration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_registration_id_seq', 1, false);


--
-- Name: st_analytical_word_template_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_analytical_word_template_id_seq', 1, false);


--
-- Name: st_platform_request_platform_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.st_platform_request_platform_request_id_seq', 27, true);


--
-- Name: system_release_information_seq_no_seq; Type: SEQUENCE SET; Schema: public; Owner: lx_iropa
--

SELECT pg_catalog.setval('public.system_release_information_seq_no_seq', 8, false);


--
-- Name: batch_job_chain batch_job_chain_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.batch_job_chain
    ADD CONSTRAINT batch_job_chain_pkey PRIMARY KEY (job_chain_no);


--
-- Name: batch_job_log batch_job_log_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.batch_job_log
    ADD CONSTRAINT batch_job_log_pkey PRIMARY KEY (seq_no);


--
-- Name: batch_job_service batch_job_service_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.batch_job_service
    ADD CONSTRAINT batch_job_service_pkey PRIMARY KEY (job_id);


--
-- Name: bl_chemicals_manufacture bl_chemicals_manufacture_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_chemicals_manufacture
    ADD CONSTRAINT bl_chemicals_manufacture_pkey PRIMARY KEY (id);


--
-- Name: bl_chemicals bl_chemicals_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_chemicals
    ADD CONSTRAINT bl_chemicals_pk PRIMARY KEY (id);


--
-- Name: bl_cost_material_montitoring bl_cost_material_montitoring_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_cost_material_montitoring
    ADD CONSTRAINT bl_cost_material_montitoring_pkey PRIMARY KEY (id);


--
-- Name: bl_cost_module bl_cost_module_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_cost_module
    ADD CONSTRAINT bl_cost_module_pkey PRIMARY KEY (id);


--
-- Name: bl_cost_process_planning bl_cost_process_planing_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_cost_process_planning
    ADD CONSTRAINT bl_cost_process_planing_pk PRIMARY KEY (id);


--
-- Name: bl_edge_manufacture bl_edge_manufacture_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_edge_manufacture
    ADD CONSTRAINT bl_edge_manufacture_pkey PRIMARY KEY (id);


--
-- Name: bl_edge bl_edge_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_edge
    ADD CONSTRAINT bl_edge_pk PRIMARY KEY (id);


--
-- Name: bl_es_report bl_es_report_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_es_report
    ADD CONSTRAINT bl_es_report_pkey PRIMARY KEY (id);


--
-- Name: bl_history bl_history_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_history
    ADD CONSTRAINT bl_history_pk PRIMARY KEY (id);


--
-- Name: bl_impurity_profile bl_impurity_profile_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_impurity_profile
    ADD CONSTRAINT bl_impurity_profile_pk PRIMARY KEY (id);


--
-- Name: bl_process_flowchart_history bl_process_flowchart_copy1_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_process_flowchart_history
    ADD CONSTRAINT bl_process_flowchart_copy1_pkey PRIMARY KEY (id);


--
-- Name: bl_process_flowchart bl_process_flowchart_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_process_flowchart
    ADD CONSTRAINT bl_process_flowchart_pkey PRIMARY KEY (id);


--
-- Name: bl_process_safety bl_process_safety_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_process_safety
    ADD CONSTRAINT bl_process_safety_pk PRIMARY KEY (id);


--
-- Name: bl_project_group bl_project_group_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_project_group
    ADD CONSTRAINT bl_project_group_pkey PRIMARY KEY (id);


--
-- Name: bl_project_info bl_project_info_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_project_info
    ADD CONSTRAINT bl_project_info_pkey PRIMARY KEY (id);


--
-- Name: bl_project_info bl_project_info_project_id_key; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_project_info
    ADD CONSTRAINT bl_project_info_project_id_key UNIQUE (project_id);


--
-- Name: bl_reagent_column_order bl_reagent_column_order_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_reagent_column_order
    ADD CONSTRAINT bl_reagent_column_order_pk PRIMARY KEY (id);


--
-- Name: bl_reagent_column_order bl_reagent_column_order_reagent_name_key; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_reagent_column_order
    ADD CONSTRAINT bl_reagent_column_order_reagent_name_key UNIQUE (reagent_name);


--
-- Name: bl_reagent_column_order bl_reagent_column_order_reagent_name_key1; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_reagent_column_order
    ADD CONSTRAINT bl_reagent_column_order_reagent_name_key1 UNIQUE (reagent_name);


--
-- Name: bl_reagent_data bl_reagent_data_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_reagent_data
    ADD CONSTRAINT bl_reagent_data_pk PRIMARY KEY (id);


--
-- Name: bl_route bl_route_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_route
    ADD CONSTRAINT bl_route_pk PRIMARY KEY (id) DEFERRABLE;


--
-- Name: bl_route bl_route_route_id_key; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_route
    ADD CONSTRAINT bl_route_route_id_key UNIQUE (route_id);


--
-- Name: bl_route_submission bl_route_submission_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_route_submission
    ADD CONSTRAINT bl_route_submission_pk PRIMARY KEY (id);


--
-- Name: bl_sm_risk_assessment_info bl_sm_risk_assessment_info_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_sm_risk_assessment_info
    ADD CONSTRAINT bl_sm_risk_assessment_info_pk PRIMARY KEY (id);


--
-- Name: bl_user_feedback bl_user_feedback_pk; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.bl_user_feedback
    ADD CONSTRAINT bl_user_feedback_pk PRIMARY KEY (id);


--
-- Name: cm_app cm_app_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_app
    ADD CONSTRAINT cm_app_pkey PRIMARY KEY (id);


--
-- Name: cm_application cm_application_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_application
    ADD CONSTRAINT cm_application_pkey PRIMARY KEY (app_no);


--
-- Name: cm_application_related cm_application_related_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_application_related
    ADD CONSTRAINT cm_application_related_pkey PRIMARY KEY (app_no, related_no);


--
-- Name: cm_authority_data cm_authority_data_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_authority_data
    ADD CONSTRAINT cm_authority_data_pkey PRIMARY KEY (rs_no);


--
-- Name: cm_authority_exempt cm_authority_exempt_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_authority_exempt
    ADD CONSTRAINT cm_authority_exempt_pkey PRIMARY KEY (rs_no);


--
-- Name: cm_datasync_register cm_datasync_register_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_datasync_register
    ADD CONSTRAINT cm_datasync_register_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_datasync_task cm_datasync_task_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_datasync_task
    ADD CONSTRAINT cm_datasync_task_pkey PRIMARY KEY (app_name, source_table, status);


--
-- Name: cm_department_info cm_department_info_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_department_info
    ADD CONSTRAINT cm_department_info_pkey PRIMARY KEY (dp_no);


--
-- Name: cm_file_upload_attach cm_file_upload_attach_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_file_upload_attach
    ADD CONSTRAINT cm_file_upload_attach_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_file_upload cm_file_upload_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_file_upload
    ADD CONSTRAINT cm_file_upload_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_menu cm_menu_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_menu
    ADD CONSTRAINT cm_menu_pkey PRIMARY KEY (menu_no);


--
-- Name: cm_resources_list cm_resources_list_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_resources_list
    ADD CONSTRAINT cm_resources_list_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_role_info cm_role_info_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_role_info
    ADD CONSTRAINT cm_role_info_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_system cm_system_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_system
    ADD CONSTRAINT cm_system_pkey PRIMARY KEY (sys_code, org_id, sys_status);


--
-- Name: cm_user_department cm_user_department_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_user_department
    ADD CONSTRAINT cm_user_department_pkey PRIMARY KEY (acct_no, org_id, dp_no);


--
-- Name: cm_user_info cm_user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_user_info
    ADD CONSTRAINT cm_user_info_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_user_openid cm_user_openid_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_user_openid
    ADD CONSTRAINT cm_user_openid_pkey PRIMARY KEY (seq_no);


--
-- Name: cm_user_role cm_user_role_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cm_user_role
    ADD CONSTRAINT cm_user_role_pkey PRIMARY KEY (acct_no, role_no, org_id);


--
-- Name: cs_category cs_category_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cs_category
    ADD CONSTRAINT cs_category_pkey PRIMARY KEY (seq_no);


--
-- Name: cs_dictionary cs_dictionary_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cs_dictionary
    ADD CONSTRAINT cs_dictionary_pkey PRIMARY KEY (seq_no);


--
-- Name: cs_user_info cs_user_info_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.cs_user_info
    ADD CONSTRAINT cs_user_info_pkey PRIMARY KEY (seq_no);


--
-- Name: data_etl_hist data_etl_hist_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.data_etl_hist
    ADD CONSTRAINT data_etl_hist_pkey PRIMARY KEY (reference_no);


--
-- Name: data_import_hist data_import_hist_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.data_import_hist
    ADD CONSTRAINT data_import_hist_pkey PRIMARY KEY (reference_no);


--
-- Name: data_import_rule data_import_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.data_import_rule
    ADD CONSTRAINT data_import_rule_pkey PRIMARY KEY (rule_name);


--
-- Name: process_reactor_list process_reactor_list_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.process_reactor_list
    ADD CONSTRAINT process_reactor_list_pkey PRIMARY KEY (id);


--
-- Name: process_selection process_selection_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.process_selection
    ADD CONSTRAINT process_selection_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_assign_task st_analytical_assign_task_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_assign_task
    ADD CONSTRAINT st_analytical_assign_task_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_basic st_analytical_basic_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_basic
    ADD CONSTRAINT st_analytical_basic_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_investigation st_analytical_investigation_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_investigation
    ADD CONSTRAINT st_analytical_investigation_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_isolation st_analytical_isolation_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_isolation
    ADD CONSTRAINT st_analytical_isolation_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_merge_log st_analytical_merge_log_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_merge_log
    ADD CONSTRAINT st_analytical_merge_log_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_registration st_analytical_registration_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_registration
    ADD CONSTRAINT st_analytical_registration_pkey PRIMARY KEY (id);


--
-- Name: st_analytical_word_template st_analytical_word_template_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_analytical_word_template
    ADD CONSTRAINT st_analytical_word_template_pkey PRIMARY KEY (id);


--
-- Name: st_platform_request st_platform_request_pkey; Type: CONSTRAINT; Schema: public; Owner: lx_iropa
--

ALTER TABLE ONLY public.st_platform_request
    ADD CONSTRAINT st_platform_request_pkey PRIMARY KEY (platform_request_id);


--
-- Name: bl_node_smiles_code_index; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX bl_node_smiles_code_index ON public.bl_node USING btree (smiles_code);


--
-- Name: bl_reagent_data_reagent_value_personal_uindex; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE UNIQUE INDEX bl_reagent_data_reagent_value_personal_uindex ON public.bl_reagent_data USING btree (reagent_name, reagent_value, personal);


--
-- Name: cm_app_id_uindex; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_app_id_uindex ON public.cm_app USING btree (id);


--
-- Name: cm_file_upload_attach_indx01; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_file_upload_attach_indx01 ON public.cm_file_upload_attach USING btree (file_name, org_id, creator);


--
-- Name: cm_file_upload_indx01; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_file_upload_indx01 ON public.cm_file_upload USING btree (reference_no);


--
-- Name: cm_file_upload_indx02; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_file_upload_indx02 ON public.cm_file_upload USING btree (file_name, reference_no);


--
-- Name: cm_resources_list_indx01; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_resources_list_indx01 ON public.cm_resources_list USING btree (rl_no);


--
-- Name: cm_user_indx01; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_user_indx01 ON public.cm_user_info USING btree (acct_no);


--
-- Name: cm_user_openid_index01; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX cm_user_openid_index01 ON public.cm_user_openid USING btree (open_id, open_type, org_id);


--
-- Name: idx_bl_edge_edge_id; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX idx_bl_edge_edge_id ON public.bl_edge USING btree (edge_id);


--
-- Name: idx_bl_history_history_id; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX idx_bl_history_history_id ON public.bl_history USING btree (history_id);


--
-- Name: idx_bl_node_node_id; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX idx_bl_node_node_id ON public.bl_node USING btree (node_id);


--
-- Name: idx_bl_reagent_name; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX idx_bl_reagent_name ON public.bl_reagent_data USING btree (reagent_name);


--
-- Name: idx_bl_route_route_id; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX idx_bl_route_route_id ON public.bl_route USING btree (route_id);


--
-- Name: idx_chemicals_edge_id; Type: INDEX; Schema: public; Owner: lx_iropa
--

CREATE INDEX idx_chemicals_edge_id ON public.bl_chemicals USING btree (edge_id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: lx_iropa
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

