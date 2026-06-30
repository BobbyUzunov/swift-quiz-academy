#!/usr/bin/env node

import fs from "fs";
import path from "path";
import { fileURLToPath, pathToFileURL } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const root = path.join(__dirname, "..");
const questionDataDir = path.join(root, "Swift Quiz Academy", "QuestionData");

const banks = [
  { module: "./question_banks/git_github.mjs", file: "git_github.json", categoryId: "git-github" },
  { module: "./question_banks/ios_development.mjs", file: "ios_development.json", categoryId: "ios-development" },
  { module: "./question_banks/architecture_mvvm.mjs", file: "architecture_mvvm.json", categoryId: "architecture-mvvm" },
  { module: "./question_banks/ai_for_developers.mjs", file: "ai_for_developers.json", categoryId: "ai-for-developers" },
  { module: "./question_banks/programming_logic.mjs", file: "programming_logic.json", categoryId: "programming-logic" },
  { module: "./question_banks/xcode_debugging.mjs", file: "xcode_debugging.json", categoryId: "xcode-debugging" },
  { module: "./question_banks/swiftui.mjs", file: "swiftui.json", categoryId: "swiftui" },
];

function makeQuestion(categoryId, difficulty, slotNumber, data) {
  const slot = String(slotNumber).padStart(2, "0");
  return {
    id: `${categoryId}-${difficulty}-${slot}`,
    categoryId,
    difficulty,
    questionEN: data.questionEN,
    questionBG: data.questionBG,
    answersEN: data.answersEN,
    answersBG: data.answersBG,
    correctAnswerEN: data.correctEN,
    correctAnswerBG: data.correctBG,
    explanationEN: data.explanationEN,
    explanationBG: data.explanationBG,
  };
}

function normalizeLevel(level) {
  return {
    questionEN: level.questionEN,
    questionBG: level.questionBG,
    answersEN: level.answersEN,
    answersBG: level.answersBG,
    correctEN: level.correctEN,
    correctBG: level.correctBG,
    explanationEN: level.explanationEN,
    explanationBG: level.explanationBG,
  };
}

async function rebuildCategory({ module: modulePath, file, categoryId }) {
  const { default: slots } = await import(pathToFileURL(path.join(__dirname, modulePath)).href);
  const questions = [];

  slots.forEach((slot, index) => {
    const slotNumber = index + 1;
    for (const difficulty of ["beginner", "intermediate", "advanced"]) {
      questions.push(makeQuestion(categoryId, difficulty, slotNumber, normalizeLevel(slot[difficulty])));
    }
  });

  const outputPath = path.join(questionDataDir, file);
  fs.writeFileSync(outputPath, `${JSON.stringify(questions, null, 2)}\n`, "utf8");
  console.log(`Rebuilt ${file}: ${questions.length} questions`);
}

async function main() {
  for (const bank of banks) {
    await rebuildCategory(bank);
  }

  console.log("Question database rebuild complete.");
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
