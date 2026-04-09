const express = require("express");

const app = express();
const port = process.env.PORT || 8080;
const region = process.env.AWS_REGION || "unknown-region";
const clusterRole = process.env.CLUSTER_ROLE || "primary";

app.get("/health", (req, res) => {
  res.json({ status: "ok", region, clusterRole });
});

app.get("/", (req, res) => {
  res.json({
    message: "multi-region dr demo backend",
    region,
    clusterRole,
    ts: new Date().toISOString(),
  });
});

app.listen(port, () => {
  console.log(`backend listening on ${port}`);
});
