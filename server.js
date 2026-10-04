const express = require("express");
const path = require("path");

const app = express();
app.use(express.json({ limit: "200kb" }));
app.use(express.static(path.join(__dirname, "public")));

// Cheia secretă: trebuie să fie aceeași și în scriptul din Roblox.
// Pe hosting o setezi ca variabilă de mediu SECRET.
const SECRET = process.env.SECRET || "schimba-ma";

// jobId (serverul Roblox) -> { t: momentul ultimului update, vehicles: [...] }
const servers = {};

// Roblox trimite aici pozițiile
app.post("/update", (req, res) => {
  if (req.get("x-key") !== SECRET) return res.sendStatus(403);
  const { jobId, vehicles } = req.body;
  if (typeof jobId !== "string" || !Array.isArray(vehicles)) return res.sendStatus(400);
  servers[jobId] = { t: Date.now(), vehicles: vehicles.slice(0, 300) };
  res.sendStatus(200);
});

// Pagina web cere de aici pozițiile
app.get("/vehicles", (req, res) => {
  const now = Date.now();
  const all = [];
  for (const [id, s] of Object.entries(servers)) {
    if (now - s.t > 10000) { // server Roblox mort (fără update de 10 secunde)
      delete servers[id];
      continue;
    }
    for (const v of s.vehicles) all.push({ ...v, server: id });
  }
  res.json(all);
});

app.listen(process.env.PORT || 3000, () => console.log("Server pornit"));
