/* eslint-disable capitalized-comments */

module.exports = async () => {
  const app = require("express")();
  const cds = require("@sap/cds");
  const bodyParser = require("body-parser");

  //const cfenv = require("cfenv");
  //const appEnv = cfenv.getAppEnv();

  const xsenv = require("@sap/xsenv");
  const services = xsenv.getServices({
    uaa: { tag: "xsuaa" },
    //  registry: { tag: "SaaS" },
  });

  const xssec = require("@sap/xssec");
  const passport = require("passport");
  passport.use("JWT", new xssec.JWTStrategy(services.uaa));
  app.use(passport.initialize());
  app.use(
    passport.authenticate("JWT", {
      session: false,
    })
  );

  app.use(bodyParser.json());

  // connect to datasource 'db' which must be the HANA instance manager
  cds.connect.to("db");

  cds.mtx.in(app).then(async () => {
    console.log("XXX_Overriding Default Provisioning... ");
    const provisioning = await cds.connect.to("ProvisioningService");
    provisioning.impl(require("./handlers/provisioning"));
  });

  // serve application defined services: in combination with a CAP Java server, this won't appear here.
  cds.serve("all").in(app);

  //Start the Server
  const port = process.env.PORT || 4004;
  const server = app.listen(port, function () {
    console.info(`app is listening at ${port}`);
  });

  return app;
};
