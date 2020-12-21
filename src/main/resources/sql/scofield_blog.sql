/*
 Navicat Premium Data Transfer

 Source Server         : docker
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : 192.168.110.200:3306
 Source Schema         : scofield_blog

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 20/12/2020 17:13:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_admin_user`;
CREATE TABLE `tb_admin_user`  (
  `admin_user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '管理员id',
  `login_user_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员登陆名称',
  `login_password` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员登陆密码',
  `nick_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '管理员显示昵称',
  `locked` tinyint(0) NULL DEFAULT 0 COMMENT '是否锁定 0未锁定 1已锁定无法登陆',
  PRIMARY KEY (`admin_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_admin_user
-- ----------------------------
INSERT INTO `tb_admin_user` VALUES (1, 'admin', 'e10adc3949ba59abbe56e057f20f883e', 'Scofield', 0);

-- ----------------------------
-- Table structure for tb_blog
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog`;
CREATE TABLE `tb_blog`  (
  `blog_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '博客表主键id',
  `blog_title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客标题',
  `blog_sub_url` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客自定义路径url',
  `blog_cover_image` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客封面图',
  `blog_content` mediumtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客内容',
  `blog_category_id` int(0) NOT NULL COMMENT '博客分类id',
  `blog_category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客分类(冗余字段)',
  `blog_tags` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '博客标签',
  `blog_status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0-草稿 1-发布',
  `blog_views` bigint(0) NOT NULL DEFAULT 0 COMMENT '阅读量',
  `enable_comment` tinyint(0) NOT NULL DEFAULT 0 COMMENT '0-允许评论 1-不允许评论',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除 0=否 1=是',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`blog_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_blog
-- ----------------------------
INSERT INTO `tb_blog` VALUES (1, 'Spring Cloud简介', '', 'http://www.scofield.com/admin/dist/img/rand/14.jpg', '一、  网站的架构演变\n    网络架构由最开始的三层mvc渐渐演变。传统的三层架构后来在互联网公司让几百人几千人同时开发一个项目已经变得不可行，并且会产生代码冲突的问题。基于SOA面向服务开发的架构，渐渐产生了微服务架构。微服务的架构的特点就是项目拆分成各个子项目，进行解耦操作，提供外部访问接口，属于敏捷开发，其实也可以视为面向接口开发。\n\n    一旦有了多个子项目，比如把淘宝网的订单系统和会员系统分开来看，就回产生如何管理接口、负载均衡、高并发情况下怎么限流断路等问题。那么这就有SpringCloud出现了。\n\n    那么springCloud的组件大概有哪些呢，我先简单介绍下：\n\nEureka  服务注册中心\n服务消费者 Rest 和 Fegin  --消费实现负载均衡ribbon\n接口网关Zuul\nHystrix  关于服务雪崩的解决方案--服务熔断、服务降级、隔离资源。\n二、  Eureka\n    eureka是个什么东西呢？它是一个服务注册中心。就拿上面的例子来说，如果要查看会员的订单详情，那么就要在会员系统的tomcat里面调用订单系统的tomcat里的方法。那么直接通过接口访问吗？显然这是不安全的。因此我们需要一个统一管理远程RPC调用的注册中心\n\n\n\n如图所示，会员系统和订单都是独立能够运行的SpringBoot项目，把SpringBoot注册进eureka中，这样我们就可以通过eureka让会员系统远程调用订单系统。具体配置要怎么做呢？\n\n    首先我们要创建eureka注册中心，这里建议用idea的工具创建SpringBoot项目。\n\n\n\n选择如图的包，如果没有则直接复制pom文件\n\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"\n         xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">\n    <modelVersion>4.0.0</modelVersion>\n    <parent>\n        <groupId>org.springframework.boot</groupId>\n        <artifactId>spring-boot-starter-parent</artifactId>\n        <version>2.1.3.RELEASE</version>\n        <relativePath/> <!-- lookup parent from repository -->\n    </parent>\n    <groupId>my</groupId>\n    <artifactId>learning</artifactId>\n    <version>0.0.1-SNAPSHOT</version>\n    <name>learning</name>\n    <description>Demo project for Spring Boot</description>\n \n    <properties>\n        <java.version>1.8</java.version>\n        <spring-cloud.version>Greenwich.SR1</spring-cloud.version>\n    </properties>\n \n    <dependencies>\n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-web</artifactId>\n        </dependency>\n        <dependency>\n            <groupId>org.springframework.cloud</groupId>\n            <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>\n        </dependency>\n \n        <dependency>\n            <groupId>org.springframework.boot</groupId>\n            <artifactId>spring-boot-starter-test</artifactId>\n            <scope>test</scope>\n        </dependency>\n    </dependencies>\n \n    <dependencyManagement>\n        <dependencies>\n            <dependency>\n                <groupId>org.springframework.cloud</groupId>\n                <artifactId>spring-cloud-dependencies</artifactId>\n                <version>${spring-cloud.version}</version>\n                <type>pom</type>\n                <scope>import</scope>\n            </dependency>\n        </dependencies>\n    </dependencyManagement>\n \n    <build>\n        <plugins>\n            <plugin>\n                <groupId>org.springframework.boot</groupId>\n                <artifactId>spring-boot-maven-plugin</artifactId>\n            </plugin>\n        </plugins>\n    </build>\n \n    <repositories>\n        <repository>\n            <id>spring-milestones</id>\n            <name>Spring Milestones</name>\n            <url>https://repo.spring.io/milestone</url>\n        </repository>\n    </repositories>\n \n</project>\n \n\n然后我们去yml文件中做如下配置\n\n#eureka的端口号\nserver:\n  port: 8888\neureka:\n  instance:\n    hostname: localhost\n  client:\n    registerWithEureka: false\n    fetchRegistry: false\n    serviceUrl:\n      defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/\n然后在启动类里添加表示为eureka注册中心\n\n@EnableEurekaServer\n@SpringBootApplication\npublic class LearningApplication {\n \n    public static void main(String[] args) {\n        SpringApplication.run(LearningApplication.class, args);\n    }\n \n}\n通过localhost:8888可以进到如下页面就表示eureka注册中心启动成功\n\n\n\nOK，那么我们要怎么把订单系统和会员系统注册进去呢？同样创建两个SpringBoot项目，创建方式和导包方式和注册中心一样。我们关注的只有yml文件是如何把这个springBoot项目注册进去的，那么我们来看看yml文件如何配置\n\neureka:\n  client:\n    serviceUrl:\n#      eureka的注册中心地址\n      defaultZone: http://localhost:8888/eureka/\nserver:\n#  此项目端口号\n  port: 8889\nspring:\n  application:\n#    注册进eureka的名字\n    name: order-server\n \n\n创建controller包并且启动\n\n@RestController\npublic class ordercontroller {\n    @RequestMapping(\"orderTest\")\n    public String orderTest(){\n        return \"this is order\";\n    }\n}\n \n//  启动类\n@EnableEurekaClient   \n@SpringBootApplication\npublic class DemoApplication {\n \n    public static void main(String[] args) {\n        SpringApplication.run(DemoApplication.class, args);\n    }\n \n}\n 再次打开注册中心网页，就发现已经注册进去\n\n\n\n重复以上步骤把会员系统也注册进去\n\n\n\n三、  PRC远程调用的方法\n    远程调用的方法有两种，我们一一来细说。\n\n    1.  第一种，通过rest的方式来调用，首先我们要导入rest的pom依赖，我们要使用用户调用订单，就在用户里添加调用依赖。先解释一下什么是ribbon-----ribbon是一个负载均衡客户端 类似nginx反向代理，可以很好的控制htt和tcp的一些行为。\n\n<dependency>\n\n<groupId>org.springframework.cloud</groupId>\n\n<artifactId>spring-cloud-starter-ribbon</artifactId>\n\n</dependency>\n\n//  在启动类里把ribbon类注入spring\n@EnableEurekaClient\n@SpringBootApplication\npublic class DemoApplication {\n \n    public static void main(String[] args) {\n        SpringApplication.run(DemoApplication.class, args);\n    }\n    @Bean\n    @LoadBalanced        // 开启负载均衡\n    public RestTemplate restTemplate(){\n        return new RestTemplate();\n    }\n}\n \npublic class memService{\n    @Autowired\n    private RestTemplate restTemplate;\n    @RequestMapping(\"/memTest\")\n    public String memTest(){\n        String str = restTemplate.getForObject(\"http://order-server/orderTest\",String.class);\n        return str;\n    }\n}\n然后我们调用会员系统的接口访问，看他会不会走到订单系统里\n\n\n\n这就是Rest远程调用的结果。\n\n    2.  Feigin\n\nFeign是一个声明式的伪Http客户端，它使得写Http客户端变得更简单。使用Feign，只需要创建一个接口并注解。它具有可插拔的注解特性，可使用Feign 注解和JAX-RS注解。Feign支持可插拔的编码器和解码器。Feign默认集成了Ribbon，并和Eureka结合，默认实现了负载均衡的效果。\n\n简而言之：\n\n·Feign 采用的是基于接口的注解\n\n·Feign 整合了ribbon\n\n   第一步依然是导入依赖\n\n<dependency>\n\n<groupId>org.springframework.cloud</groupId>\n\n<artifactId>spring-cloud-starter-feign</artifactId>\n\n</dependency>\n\n@Service\n@FeignClient(\"order-server\")\npublic interface orderFeign {\n    @RequestMapping(\"/orderTest\")\n    public String orderTest();\n}\n@RestController\npublic class memController {\n    @Autowired\n    private OrderFeign orderFeign;\n    @RequestMapping(\"/memTest\")\n    public String memTest(){\n        String str = orderFeign.orderTest();\n        return str;\n    }\n}\n \n// 启动类\n@EnableEurekaClient\n@EnableFeignClients\n@SpringBootApplication\npublic class DemoApplication {\n \n    public static void main(String[] args) {\n        SpringApplication.run(DemoApplication.class, args);\n    }\n \n}\n\n\n因此成功。这两个方式使用ribbon均衡负载，一个需要手动启动，fegin是自动启动。\n\n四、  路由网关（ZUUL）\n    路由网关有什么作用呢？上面订单和会员系统已经注册进服务中心，两者之间是通过网址直接访问。但是如果在浏览器里由订单访问会员，会因为域名不同而导致跨域问题。跨域问题的解决方案可以使用http client设置、设置请求头、nginx转发解决，那么在SpringCloud里面当然提供了一套解决方案，那就是网关ZUUL。\n\n\n\n如图所示，当一个客户端如果直接访问时，会因为域名不同导致跨域问题。而我们所需要做的就是在前面设置一个网关变成my.com/vip  my.com/order，这样就不会产生跨域的问题。接下来我们来设置zuul。\n\n    第一步首先也要注册进eureka,导入依赖。\n\n<dependency>\n<groupId>org.springframework.cloud</groupId>\n<artifactId>spring-cloud-starter-zuul</artifactId>\n</dependency>\n 第二步配置yml文件..\n\n#注册进eureka\neureka:\n  client:\n    serviceUrl:\n      defaultZone: http://localhost:8888/eureka/\n#配置网关端口号\nserver:\n  port: 8080\nspring:\n  application:\n    name: zuul-server\n#配置网关转发详情\nzuul:\n  routes:\n    api-a:\n      path: /member/**\n      service-id: member-server\n    api-b:\n      path: /order/**\n      service-id: order-server\n//  开启网关\n@EnableZuulProxy\n@SpringBootApplication\npublic class DemoApplication {\n \n    public static void main(String[] args) {\n        SpringApplication.run(DemoApplication.class, args);\n    }\n \n}\n\n\n 访问配置的网关地址8080，调用member-server里的方法，成功！还可以使用网关过滤信息。具体怎样过滤不做赘述。\n\n五、  断路器（Hystrix)\n为什么需要 Hystrix?\n在微服务架构中，我们将业务拆分成一个个的服务，服务与服务之间可以相互调用（RPC）。为了保证其高可用，单个服务又必须集群部署。由于网络原因或者自身的原因，服务并不能保证服务的100%可用，如果单个服务出现问题，调用这个服务就会出现网络延迟，此时若有大量的网络涌入，会形成任务累计，导致服务瘫痪，甚至导致服务“雪崩”。为了解决这个问题，就出现断路器模型。\n\n \n\n什么是服务雪崩\n分布式系统中经常会出现某个基础服务不可用造成整个系统不可用的情况, 这种现象被称为服务雪崩效应. 为了应对服务雪崩, 一种常见的做法是手动服务降级. 而Hystrix的出现,给我们提供了另一种选择.\n\n通俗来说： 就是对一个方法的PRC调用并发数量太大\n\n \n\n \n\n服务雪崩应对策略\n针对造成服务雪崩的不同原因, 可以使用不同的应对策略:\n\n1. 流量控制\n\n2. 改进缓存模式\n\n3. 服务自动扩容\n\n服务调用者降级服务\n\n \n\n流量控制 的具体措施包括:\n\n·网关限流\n\n·用户交互限流\n\n·关闭重试\n\n \n\n什么是服务降级\n所有的RPC技术里面服务降级是一个最为重要的话题，所谓的降级指的是当服务的提供方不可使用的时候，程序不会出现异常，而会出现本地的操作调用。\n\n通俗解释来说：就是上面例子里的会员系统访问订单系统，执行远程RPC调用方法，但是当达到一定并发量的时候，比如200个人同时访问 orderTest()方法时，tomcat的容量设置的只有150个，剩余的50个人就在外面等待一直等待。服务降级就是不让他们一直等待，调用本地的方法来fallback消息。而不再去PRC方法。\n\nHystrix的作用\n\n1.断路器机制\n\n断路器很好理解, 当Hystrix Command请求后端服务失败数量超过一定比例(默认50%), 断路器会切换到开路状态(Open). 这时所有请求会直接失败而不会发送到后端服务. 断路器保持在开路状态一段时间后(默认5秒), 自动切换到半开路状态(HALF-OPEN). 这时会判断下一次请求的返回情况, 如果请求成功, 断路器切回闭路状态(CLOSED), 否则重新切换到开路状态(OPEN). Hystrix的断路器就像我们家庭电路中的保险丝, 一旦后端服务不可用, 断路器会直接切断请求链, 避免发送大量无效请求影响系统吞吐量, 并且断路器有自我检测并恢复的能力.\n\n2.Fallback\n\nFallback相当于是降级操作. 对于查询操作, 我们可以实现一个fallback方法, 当请求后端服务出现异常的时候, 可以使用fallback方法返回的值. fallback方法的返回值一般是设置的默认值或者来自缓存.\n\n3.资源隔离\n\n在Hystrix中, 主要通过线程池来实现资源隔离. 通常在使用的时候我们会根据调用的远程服务划分出多个线程池. 例如调用产品服务的Command放入A线程池, 调用账户服务的Command放入B线程池. 这样做的主要优点是运行环境被隔离开了. 这样就算调用服务的代码存在bug或者由于其他原因导致自己所在线程池被耗尽时, 不会对系统的其他服务造成影响. 但是带来的代价就是维护多个线程池会对系统带来额外的性能开销. 如果是对性能有严格要求而且确信自己调用服务的客户端代码不会出问题的话, 可以使用Hystrix的信号模式(Semaphores)来隔离资源.\n\n第一步首先是导入依赖\n\n<dependency>\n<groupId>org.springframework.cloud</groupId>\n<artifactId>spring-cloud-starter-hystrix</artifactId>\n</dependency>\nRest方式调用\n\n@HystrixCommand(fallbackMethod = \"testError\")\n@RequestMapping(\"/memTest\")\n    public String memTest(){\n        String str = restTemplate.getForObject(\"http://order-server/orderTest\",String.class);\n        return str;\n    }\n    public String testError(){\n        //远程调用失败，调用此方法\n    }\n \n \n//启动方式\n@EnableEurekaClient\n@EnableHystrix\n@SpringBootApplication\npublic class MemApp {\n \n	public static void main(String[] args) {\n		SpringApplication.run(OrderApp.class, args);\n	}\nFegin方式调用\n\n    yml文件新增配置\n\nfeign:\n\n   hystrix:\n\n     enabled: true\n\n    注册一个继承了Fegin接口的类到Spring容器中\n\n@Component\npublic class MemberFeignService implements orderFeign {\n \n	public String errorMsg {\n		return \"出错啦\";\n	}\n}\n \n@Service\n@FeignClient(\"order-server\"，fallback=MemberFeignService.class)\npublic interface orderFeign {\n    @RequestMapping(\"/orderTest\")\n    public String orderTest();\n}\n  所以整个流程就是并发访问量太大导致服务雪崩。然后出发PRC的熔断机制。最后会根据情况来进行隔离资源。', 1, 'Java', 'Spring Cloud', 1, 4, 0, 0, '2020-12-20 08:26:29', '2020-12-20 08:26:29');
INSERT INTO `tb_blog` VALUES (2, '我来发布一篇博客', '', 'http://www.scofield.com/admin/dist/img/rand/18.jpg', '# 我就要发！！！！！\n### 2021祝大家恭喜发财', 1, 'Java', '测试', 1, 1, 0, 0, '2020-12-20 08:52:18', '2020-12-20 08:52:18');
INSERT INTO `tb_blog` VALUES (3, 'Scodield', 'about', 'http://www.scofield.com/upload/20201220_17122828.jpg', '## About me\n\n我是xxx，一名Java开发者，技术一般，经历平平，但是也一直渴望进步，同时也努力活着，为了人生不留遗憾，也希望能够一直做着自己喜欢的事情，得闲时分享心得、分享一些浅薄的经验，等以后老得不能再老了，就说故事已经讲完了,不去奢求圆满。\n\n相信浏览这段话的你也知道，学习是一件极其枯燥而无聊的过程，甚至有时候显得很无助，我也想告诉你，成长就是这样一件残酷的事情，任何成功都不是一蹴而就，需要坚持、需要付出、需要你的毅力，短期可能看不到收获，因为破茧成蝶所耗费的时间不是一天。\n\n## Contact\n\n- 我的邮箱：543196660@qq.com\n- 我的网站：www.scofield.com', 10, 'About', '世界上有一个很可爱的人,现在这个人就在看这句话', 1, 221, 0, 0, '2020-03-12 00:31:15', '2020-11-12 00:31:15');

-- ----------------------------
-- Table structure for tb_blog_category
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_category`;
CREATE TABLE `tb_blog_category`  (
  `category_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '分类表主键',
  `category_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类的名称',
  `category_icon` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类的图标',
  `category_rank` int(0) NOT NULL DEFAULT 1 COMMENT '分类的排序值 被使用的越多数值越大',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除 0=否 1=是',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_blog_category
-- ----------------------------
INSERT INTO `tb_blog_category` VALUES (1, 'Java', '/admin/dist/img/category/02.png', 6, 0, '2020-12-20 08:21:15');
INSERT INTO `tb_blog_category` VALUES (2, 'Linux', '/admin/dist/img/category/13.png', 1, 0, '2020-12-20 08:21:23');
INSERT INTO `tb_blog_category` VALUES (3, '数据库', '/admin/dist/img/category/04.png', 1, 0, '2020-12-20 08:21:35');
INSERT INTO `tb_blog_category` VALUES (10, 'About', '/admin/dist/img/category/10.png', 9, 0, '2020-11-12 00:28:49');

-- ----------------------------
-- Table structure for tb_blog_comment
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_comment`;
CREATE TABLE `tb_blog_comment`  (
  `comment_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `blog_id` bigint(0) NOT NULL DEFAULT 0 COMMENT '关联的blog主键',
  `commentator` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论者名称',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论人的邮箱',
  `website_url` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '网址',
  `comment_body` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论内容',
  `comment_create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '评论提交时间',
  `commentator_ip` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '评论时的ip地址',
  `reply_body` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '回复内容',
  `reply_create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '回复时间',
  `comment_status` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否审核通过 0-未审核 1-审核通过',
  `is_deleted` tinyint(0) NULL DEFAULT 0 COMMENT '是否删除 0-未删除 1-已删除',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_blog_comment
-- ----------------------------

-- ----------------------------
-- Table structure for tb_blog_tag
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_tag`;
CREATE TABLE `tb_blog_tag`  (
  `tag_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '标签表主键id',
  `tag_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名称',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除 0=否 1=是',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_blog_tag
-- ----------------------------
INSERT INTO `tb_blog_tag` VALUES (1, 'Spring', 0, '2020-12-20 08:20:02');
INSERT INTO `tb_blog_tag` VALUES (2, 'Spring MVC', 0, '2020-12-20 08:20:14');
INSERT INTO `tb_blog_tag` VALUES (3, 'Spring Boot', 0, '2020-12-20 08:20:27');
INSERT INTO `tb_blog_tag` VALUES (4, 'MySQL', 0, '2020-12-20 08:20:33');
INSERT INTO `tb_blog_tag` VALUES (5, 'Spring Cloud', 0, '2020-12-20 08:20:44');
INSERT INTO `tb_blog_tag` VALUES (6, 'Nginx', 0, '2020-12-20 08:20:51');
INSERT INTO `tb_blog_tag` VALUES (7, 'Hadoop', 0, '2020-12-20 08:20:59');
INSERT INTO `tb_blog_tag` VALUES (8, 'Java', 0, '2020-12-20 08:21:04');
INSERT INTO `tb_blog_tag` VALUES (9, '测试', 0, '2020-12-20 08:52:18');
INSERT INTO `tb_blog_tag` VALUES (10, '世界上有一个很可爱的人', 0, '2020-12-20 09:12:29');
INSERT INTO `tb_blog_tag` VALUES (11, '现在这个人就在看这句话', 0, '2020-12-20 09:12:29');

-- ----------------------------
-- Table structure for tb_blog_tag_relation
-- ----------------------------
DROP TABLE IF EXISTS `tb_blog_tag_relation`;
CREATE TABLE `tb_blog_tag_relation`  (
  `relation_id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '关系表id',
  `blog_id` bigint(0) NOT NULL COMMENT '博客id',
  `tag_id` int(0) NOT NULL COMMENT '标签id',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`relation_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_blog_tag_relation
-- ----------------------------
INSERT INTO `tb_blog_tag_relation` VALUES (4, 1, 5, '2020-12-20 08:57:40');
INSERT INTO `tb_blog_tag_relation` VALUES (5, 2, 9, '2020-12-20 09:01:18');
INSERT INTO `tb_blog_tag_relation` VALUES (6, 3, 10, '2020-12-20 09:12:29');
INSERT INTO `tb_blog_tag_relation` VALUES (7, 3, 11, '2020-12-20 09:12:29');

-- ----------------------------
-- Table structure for tb_config
-- ----------------------------
DROP TABLE IF EXISTS `tb_config`;
CREATE TABLE `tb_config`  (
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置项的名称',
  `config_value` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '配置项的值',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '修改时间',
  PRIMARY KEY (`config_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_config
-- ----------------------------
INSERT INTO `tb_config` VALUES ('footerAbout', 'your personal blog. have fun.', '2019-11-11 20:33:23', '2020-12-20 08:17:20');
INSERT INTO `tb_config` VALUES ('footerCopyRight', '2020 Scofield', '2018-11-11 20:33:31', '2020-12-20 08:17:20');
INSERT INTO `tb_config` VALUES ('footerICP', '豫ICP备123456789号-3', '2019-11-11 20:33:27', '2020-12-20 08:17:20');
INSERT INTO `tb_config` VALUES ('footerPoweredBy', 'https://github.com/scofield96', '2019-11-11 20:33:36', '2020-12-20 08:17:20');
INSERT INTO `tb_config` VALUES ('footerPoweredByURL', 'https://github.com/scofield96', '2019-11-11 20:33:39', '2020-12-20 08:17:20');
INSERT INTO `tb_config` VALUES ('websiteDescription', 'Scofield blog是SpringBoot2+Thymeleaf+Mybatis建造的个人博客网站.SpringBoot实战博客源码.个人博客搭建', '2019-11-11 20:33:04', '2020-12-20 08:16:49');
INSERT INTO `tb_config` VALUES ('websiteIcon', '/admin/dist/img/favicon.png', '2019-11-11 20:33:11', '2020-12-20 08:16:49');
INSERT INTO `tb_config` VALUES ('websiteLogo', '/admin/dist/img/logo2.png', '2019-11-11 20:33:08', '2020-12-20 08:16:49');
INSERT INTO `tb_config` VALUES ('websiteName', 'personal blog', '2019-11-11 20:33:01', '2020-12-20 08:16:49');
INSERT INTO `tb_config` VALUES ('yourAvatar', '/admin/dist/img/13.png', '2019-11-11 20:33:14', '2020-12-20 08:17:21');
INSERT INTO `tb_config` VALUES ('yourEmail', '543196660@qq.com', '2019-11-11 20:33:17', '2020-12-20 08:17:21');
INSERT INTO `tb_config` VALUES ('yourName', 'scofield', '2019-11-11 20:33:20', '2020-12-20 08:17:21');

-- ----------------------------
-- Table structure for tb_link
-- ----------------------------
DROP TABLE IF EXISTS `tb_link`;
CREATE TABLE `tb_link`  (
  `link_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '友链表主键id',
  `link_type` tinyint(0) NOT NULL DEFAULT 0 COMMENT '友链类别 0-友链 1-推荐 2-个人网站',
  `link_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站名称',
  `link_url` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站链接',
  `link_description` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '网站描述',
  `link_rank` int(0) NOT NULL DEFAULT 0 COMMENT '用于列表排序',
  `is_deleted` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除 0-未删除 1-已删除',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '添加时间',
  PRIMARY KEY (`link_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_link
-- ----------------------------
INSERT INTO `tb_link` VALUES (1, 1, '百度', 'http://www.baidu.com', '什么不会问百度', 0, 0, '2020-12-20 08:22:10');

SET FOREIGN_KEY_CHECKS = 1;
