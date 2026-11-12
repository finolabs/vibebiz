# Liên kết tài liệu: {{Idea title}}

<!--
  Written by the package step after it publishes or updates the outputs, from
  the "links" object in exports/data.json; the two must match. Rules:
  - Exactly the four lines below, in this order, with these labels. Each label
    maps to one key in data.json "links":
      Bản trình bày cho ban lãnh đạo (Artifact)  -> board_artifact
      Tài liệu cho đội kỹ thuật (Artifact)        -> tech_artifact
      Bản trình bày trên Google Slides            -> slides
      Tài liệu trên Google Docs                   -> docs
    For an idea whose language is English, use these labels instead:
      Board deck (Artifact), Tech document (Artifact),
      Google Slides deck, Google Docs document.
    For any other language, write the labels in that language, in the same
    order, and keep the same order of keys.
  - After the colon write the https:// address exactly as in data.json, or
    "chưa tạo" ("not created" for English) when the key is null. Never write
    another scheme, a file path or a public sharing link: every output stays
    private and the user shares it themselves.
  - Artifacts are updated at the same address on re-packaging, so their lines
    normally stay the same; Slides and Docs keep their address too.
  - The version line is the export date, ISO YYYY-MM-DD, the same as
    data.json idea.version.
  - The table of contents copies every https:// line, using the label before
    the colon as the link name.
  Headings and labels are user-facing and follow the idea's language.
-->

Phiên bản: {{YYYY-MM-DD}}

- Bản trình bày cho ban lãnh đạo (Artifact): {{board_artifact URL or "chưa tạo"}}
- Tài liệu cho đội kỹ thuật (Artifact): {{tech_artifact URL or "chưa tạo"}}
- Bản trình bày trên Google Slides: {{slides URL or "chưa tạo"}}
- Tài liệu trên Google Docs: {{docs URL or "chưa tạo"}}

Các liên kết này chỉ mình bạn xem được. Muốn ban lãnh đạo hoặc đội kỹ thuật xem, bạn tự chia sẻ từ Claude hoặc Google Drive.
