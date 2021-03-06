package adept.cli

import adept.cli.commands.Commands

object Main extends App {
  def help(error: Option[String]) = error.getOrElse("")+"""
  |usage: adept <command> <options>
  |commands:
  |""".stripMargin+{
    val maxLength = Commands.all.map(_._1).maxBy(_.length).length
    Commands.all.map(c => c._1 + "   " + " "*(maxLength - c._1.length) + c._2.shortDescription).mkString("   ", "\n   ", "")}
  
  
  def commandParser(args: List[String]) = {
    if (args.headOption == Some("-h") || args.headOption == Some("--help"))
      println(help(None))
    else
      args match {  
        case command :: commandArgs =>
          Commands.all.get(command) match {
            case Some(command) =>
              command.execute(commandArgs)
              .left.map{ error => 
                println("Error: "+ error)
              }.right.foreach{ msg => 
                println(msg)
              }
            case _ => println(help(Some("unknown command: '"+command+"'")))
          }
        case noCommand => {
          println(help(Some("no command specified!")))
        }
    }
  }
  commandParser(args.toList)
}
