function add_dense_benchmarks!()
    for n in (2, 20, 200, 2000)
        layer = Dense(n => n)
        x, ps, st = general_setup(layer, (n, 128))
        simple_chains = Lux.ToSimpleChainsAdaptor((static(n),))
        benchmark_forward_pass(
            "Dense($n => $n)", "($n, 128)", layer, x, ps, st; simple_chains)
    end

    return
end

function add_conv_benchmarks!()
    for ch in (1, 3, 16, 64)
        layer = Conv((3, 3), ch => ch)
        x, ps, st = general_setup(layer, (64, 64, ch, 128))
        simple_chains = Lux.ToSimpleChainsAdaptor((static(64), static(64), static(ch)))
        benchmark_forward_pass("Conv((3, 3), $ch => $ch)", "(64, 64, $ch, 128)",
            layer, x, ps, st; simple_chains)
    end
end

add_dense_benchmarks!()
add_conv_benchmarks!()
