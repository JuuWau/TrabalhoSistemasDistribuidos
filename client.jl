using HTTP
using Base.Threads

function comprar()
    try
        response = HTTP.get("http://server:8080/reservar")
        println("Resposta: ", String(response.body))
        sleep(0.5)
    catch e
        println("Erro: ", e)
    end
end

function main()
    threads = []

    for i in 1:5
        push!(threads, Threads.@spawn comprar())
    end

    for t in threads
        fetch(t)
    end
end

while true
    main()
    sleep(5) 
end